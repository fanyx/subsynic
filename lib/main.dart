import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'app/app.dart';
import 'log.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initLogging();

  runApp(const ProviderScope(child: MyApp()));
}
