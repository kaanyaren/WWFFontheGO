import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wwff_on_the_go/main.dart';

void main() {
  testWidgets('Initial scan test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const ProviderScope(child: WwffApp()));

    // Verify that our app starts.
    expect(find.byType(MaterialApp), findsOneWidget);
  });
}
