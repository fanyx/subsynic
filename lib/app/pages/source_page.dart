import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../log.dart';
import '../../models/settings.dart';
import '../../services/settings.dart';
import '../items.dart';
import '../ui.dart';

@RoutePage()
class SourcePage extends HookConsumerWidget {
  const SourcePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final server = ref.watch(settingsServiceProvider.select((s) => s.server));
    final form = useState(GlobalKey<FormState>()).value;
    final isSaving = useState(false);

    final address = _LabeledTextField(
      label: 'Server address',
      initialValue: server?.address.toString(),
      keyboardType: TextInputType.url,
      autofillHints: const [AutofillHints.url],
      validator: (value) {
        if (!value.contains(RegExp(r'https?:\/\/'))) {
          return 'Must be a valid URL';
        }
        return null;
      },
    );
    final username = _LabeledTextField(
      label: 'Username',
      initialValue: server?.username,
      autofillHints: const [AutofillHints.username],
    );
    final password = _LabeledTextField(
      label: 'Password',
      initialValue: server?.password,
      obscureText: true,
      autofillHints: const [AutofillHints.password],
    );

    return Scaffold(
      appBar: AppBar(),
      floatingActionButton: FloatingActionButton.extended(
        heroTag: null,
        icon: isSaving.value
            ? const SizedBox(
                height: 24,
                width: 24,
                child: CircularProgressIndicator(),
              )
            : const Icon(Icons.save_rounded),
        label: Text(server == null ? 'Add server' : 'Save'),
        onPressed: !isSaving.value
            ? () async {
                final router = context.router;
                if (!form.currentState!.validate()) {
                  return;
                }

                var error = false;
                try {
                  isSaving.value = true;
                  await ref.read(settingsServiceProvider.notifier).saveServer(
                        ServerSettings(
                          address: Uri.parse(address.value),
                          username: username.value,
                          password: password.value,
                          useTokenAuth: true,
                        ),
                      );
                } catch (e, st) {
                  if (context.mounted) {
                    showErrorSnackbar(context, e.toString());
                  }
                  log.severe('Saving server', e, st);
                  error = true;
                } finally {
                  isSaving.value = false;
                }

                if (!error) {
                  router.pop();
                }
              }
            : null,
      ),
      body: Form(
        key: form,
        child: AutofillGroup(
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            children: [
              address,
              username,
              password,
              const SizedBox(height: 12),
              const Text(
                'The server is validated (ping) before saving. '
                'Downloads and local library files are kept.',
                style: TextStyle(fontSize: 12),
              ),
              const FabPadding(),
            ],
          ),
        ),
      ),
    );
  }
}

class _LabeledTextField extends HookConsumerWidget {
  final String label;
  final String? initialValue;
  final bool obscureText;
  final TextInputType? keyboardType;
  final Iterable<String>? autofillHints;
  final String? Function(String value)? validator;

  // ignore: prefer_const_constructors_in_immutables
  _LabeledTextField({
    required this.label,
    this.initialValue,
    this.obscureText = false,
    this.keyboardType,
    this.validator,
    this.autofillHints,
  });

  late final TextEditingController _controller;

  String get value => _controller.text;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    _controller = useTextEditingController(text: initialValue);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(label, style: theme.textTheme.titleMedium),
          const SizedBox(height: 4),
          TextFormField(
            controller: _controller,
            obscureText: obscureText,
            keyboardType: keyboardType,
            autofillHints: autofillHints,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return '$label is required';
              }
              return validator?.call(value);
            },
          ),
        ],
      ),
    );
  }
}
