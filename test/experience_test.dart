import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:myportofolio_mobile/main.dart';

void main() {
  testWidgets('menambahkan experience dan menampilkan SnackBar sukses', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MyApp());

    final experienceCard = find.text('Experience');
    await tester.ensureVisible(experienceCard);
    await tester.tap(experienceCard);
    await tester.pumpAndSettle();

    final textFields = find.byType(TextFormField);
    await tester.enterText(textFields.at(0), 'Mobile Developer Intern');
    await tester.enterText(textFields.at(1), 'Developed Flutter applications');
    await tester.enterText(textFields.at(2), 'Internship');
    await tester.tap(find.text('Save'));
    await tester.pump();

    expect(find.text('Experience berhasil ditambahkan'), findsOneWidget);
  });
}
