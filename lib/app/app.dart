import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../services/settings.dart';
import '../state/init.dart';
import 'ui.dart';

class MyApp extends HookConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final init = ref.watch(initProvider);
    return init.when(
      data: (_) => const App(),
      error: (e, s) => Directionality(
        textDirection: TextDirection.ltr,
        child: Container(
          color: Colors.red[900],
          child: Column(children: [
            const SizedBox(height:100),
            Text(e.toString()),
            Text(s.toString()),
          ]),
        ),
      ),
      loading: () => const Center(child: CircularProgressIndicator()),
    );
  }
}

class App extends HookConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appRouter = ref.watch(routerProvider);
    final theme = ref.watch(baseThemeProvider);
    final hasServer = ref.watch(
      settingsServiceProvider.select((value) => value.server != null),
    );

    final routerConfig = useMemoized(
      () => appRouter.config(
        deepLinkBuilder: (deepLink) => hasServer
            ? DeepLink.path('/library/albums')
            : DeepLink.path('/settings'),
      ),
      [appRouter, hasServer],
    );

    return MaterialApp.router(
      theme: theme,
      debugShowCheckedModeBanner: false,
      routerConfig: routerConfig,
    );
  }
}
