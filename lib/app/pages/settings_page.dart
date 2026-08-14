import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:saf/saf.dart';

import '../../services/library_scan.dart';
import '../../services/network/storage.dart';
import '../../services/settings.dart';
import '../app_router.dart';
import '../ui.dart';

final _saf = Saf();

@RoutePage()
class SettingsPage extends HookConsumerWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(settingsServiceProvider);
    final server = settings.server;
    final libraryRoot = settings.app.libraryRootUri;
    final embedCover = settings.app.embedCover;

    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: ListView(
        padding: const EdgeInsets.only(bottom: 32),
        children: [
          const _SectionHeader('Server'),
          if (server == null)
            ListTile(
              title: const Text('No server configured'),
              subtitle: const Text(
                  'Add your Subsonic server to browse and download your library.'),
              trailing: const Icon(Icons.add_rounded),
              onTap: () => context.pushRoute(const SourceRoute()),
            )
          else
            ListTile(
              leading: const Icon(Icons.dns_rounded),
              title: Text(server.address.toString()),
              subtitle: Text(server.username),
              trailing: IconButton(
                icon: const Icon(Icons.edit_rounded),
                onPressed: () => context.pushRoute(const SourceRoute()),
              ),
            ),
          const _SectionHeader('Library'),
          ListTile(
            leading: const Icon(Icons.folder_rounded),
            title: const Text('Library location'),
            subtitle: Text(
              humanizeLibraryRootUri(libraryRoot),
              maxLines: 2,
              softWrap: false,
              overflow: TextOverflow.fade,
            ),
            trailing: IconButton(
              icon: const Icon(Icons.folder_open_rounded),
              onPressed: () async {
                try {
                  final uri = await _pickLibraryRoot();
                  if (uri == null) return;
                  final old = libraryRoot;
                  if (old != null &&
                      old.scheme == 'content' &&
                      old != uri) {
                    try {
                      await _saf.releasePersistedPermission(old.toString());
                    } catch (_) {}
                  }
                  await ref
                      .read(settingsServiceProvider.notifier)
                      .setLibraryRoot(uri);
                } catch (e) {
                  if (context.mounted) {
                    showErrorSnackbar(context, e.toString());
                  }
                }
              },
            ),
          ),
          SwitchListTile(
            secondary: const Icon(Icons.image_rounded),
            title: const Text('Embed cover art'),
            subtitle: const Text(
              'Write cover art into downloaded Opus files. '
              'cover.jpg is always written regardless.',
            ),
            value: embedCover,
            onChanged: (value) =>
                ref.read(settingsServiceProvider.notifier).setEmbedCover(value),
          ),
          const _SectionHeader('Maintenance'),
          ListTile(
            leading: const Icon(Icons.sync_problem_rounded),
            title: const Text('Scan library'),
            subtitle: const Text('Verify downloaded files still exist on disk.'),
            trailing: IconButton(
              icon: const Icon(Icons.play_arrow_rounded),
              onPressed: () async {
                try {
                  await ref.read(libraryScanServiceProvider.notifier).scan();
                } catch (e) {
                  if (context.mounted) {
                    showErrorSnackbar(context, e.toString());
                  }
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;

  const _SectionHeader(this.title);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Text(title, style: theme.textTheme.headlineSmall),
          ),
        ),
        const SizedBox(height: 4),
      ],
    );
  }
}

/// Picks the library root via the system SAF folder picker
/// (`ACTION_OPEN_DOCUMENT_TREE`); the returned `content://` tree URI is made
/// persistable by the `saf` package, so the grant survives restarts. No
/// runtime storage permission is needed.
Future<Uri?> _pickLibraryRoot() async {
  final dir = await _saf.pickDirectory();
  return dir == null ? null : Uri.parse(dir.uri);
}
