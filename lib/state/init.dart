import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../app/app_router.dart';
import '../app/pages/library_page.dart';
import '../services/settings.dart';

part 'init.g.dart';

@Riverpod(keepAlive: true)
AppRouter router(Ref ref) {
  return AppRouter();
}

@Riverpod(keepAlive: true)
FutureOr<void> init(Ref ref) async {
  ref.watch(routerProvider);

  await ref.read(settingsServiceProvider.notifier).init();

  // Sort/filter state restoration. The SAF tree grant is already persisted in
  // the DB and restored automatically by the system on launch.
  await ref.watch(libraryListsProvider.notifier).init();
}
