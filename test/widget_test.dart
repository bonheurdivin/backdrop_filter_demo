import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:backdrop_filter_demo/main.dart';

void main() {
  testWidgets('Glass card renders with a BackdropFilter',
      (WidgetTester tester) async {
    await tester.pumpWidget(const GlassDemoApp());

    expect(find.text('Midnight Drive'), findsOneWidget);
    expect(find.byType(BackdropFilter), findsOneWidget);
  });
}