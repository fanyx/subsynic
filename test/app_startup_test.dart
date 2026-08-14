import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:drift/native.dart';
import 'package:subsynic/app/app.dart';
import 'package:subsynic/database/database.dart';

void main() {
  testWidgets('app renders past init gate and lands on settings when no server',
      (tester) async {
    final db = SyncDatabase.connection(NativeDatabase.memory());

    await tester.pumpWidget(
      ProviderScope(
        overrides: [databaseProvider.overrideWithValue(db)],
        child: const MyApp(),
      ),
    );

    // init runs async (settings + library lists + router)
    await tester.pump(const Duration(milliseconds: 100));
    await tester.pump(const Duration(milliseconds: 100));

    // Should no longer be the init spinner.
    final spinner = find.byType(CircularProgressIndicator);
    expect(spinner, findsNothing, reason: 'init should have completed');

    // Allow router/deep-link to settle.
    await tester.pump(const Duration(seconds: 1));
    await tester.pump(const Duration(seconds: 1));

    expect(find.text('Settings'), findsWidgets);
    await db.close();
  });
}
