import 'package:flutter_test/flutter_test.dart';
import 'package:myportofolio_mobile/main.dart';
import 'package:myportofolio_mobile/screens/login_screen.dart';

void main() {
  testWidgets('menampilkan menu portfolio dan fitur Assignment 8', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('2506657270'), findsOneWidget);
    expect(find.text('Ranu Ario Sulistianto'), findsOneWidget);
    expect(find.text('PBP F'), findsOneWidget);
    expect(find.text('Lihat Proyek'), findsOneWidget);
    expect(find.text('Tambah Proyek'), findsOneWidget);
    expect(find.text('Skill'), findsOneWidget);
    expect(find.text('Experience'), findsOneWidget);
    expect(find.text('Logout'), findsOneWidget);
  });

  testWidgets('tambah project meminta login untuk pengguna anonim', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MyApp());
    await tester.tap(find.text('Tambah Proyek'));
    await tester.pumpAndSettle();

    expect(find.byType(LoginScreen), findsOneWidget);
    expect(find.text('Login untuk menambahkan project'), findsOneWidget);
  });
}
