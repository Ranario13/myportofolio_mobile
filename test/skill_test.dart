import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:myportofolio_mobile/main.dart';

void main() {
  testWidgets('menambahkan skill dan menampilkan SnackBar sukses', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MyApp());

    await tester.tap(find.text('Skill'));
    await tester.pumpAndSettle();

    final textFields = find.byType(TextFormField);
    await tester.enterText(textFields.at(0), 'Flutter');
    await tester.enterText(textFields.at(1), 'Mobile application development');
    await tester.enterText(textFields.at(2), 'Programming');
    await tester.tap(find.text('Save'));
    await tester.pump();

    expect(find.text('Skill berhasil ditambahkan'), findsOneWidget);
  });
}
