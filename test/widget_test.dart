import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:myportofolio_mobile/main.dart';

void main() {
  testWidgets('menampilkan informasi pemilik dan tombol portfolio', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('2506657270'), findsOneWidget);
    expect(find.text('Ranu Ario Sulistianto'), findsOneWidget);
    expect(find.text('PBP F'), findsOneWidget);
    expect(find.text('Lihat Proyek'), findsOneWidget);
    expect(find.text('Tambah Proyek'), findsOneWidget);
    expect(find.text('Logout'), findsOneWidget);
  });

  testWidgets('membuka form dari kartu Tambah Proyek', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MyApp());

    await tester.tap(find.text('Tambah Proyek'));
    await tester.pumpAndSettle();

    expect(find.text('Add Project Form'), findsOneWidget);
  });

  testWidgets('membuka form dari drawer', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    await tester.tap(find.byTooltip('Open navigation menu'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Add Project'));
    await tester.pumpAndSettle();

    expect(find.text('Add Project Form'), findsOneWidget);
  });

  testWidgets('menampilkan error saat field wajib kosong', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MyApp());

    await tester.tap(find.text('Tambah Proyek'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Save'));
    await tester.pumpAndSettle();

    expect(
      find.text('Nama proyek tidak boleh kosong.'),
      findsOneWidget,
    );
    expect(find.text('Deskripsi proyek tidak boleh kosong.'), findsOneWidget);
    expect(find.text('Teknologi tidak boleh kosong.'), findsOneWidget);
  });

  testWidgets('menampilkan dialog ringkasan setelah input valid disimpan', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MyApp());

    await tester.tap(find.text('Tambah Proyek'));
    await tester.pumpAndSettle();

    final textFields = find.byType(TextFormField);
    await tester.enterText(textFields.at(0), 'Portfolio Mobile');
    await tester.enterText(
      textFields.at(1),
      'Aplikasi portofolio mobile dengan Flutter.',
    );
    await tester.enterText(textFields.at(2), 'Flutter, Dart');
    await tester.enterText(textFields.at(3), 'https://example.com');
    await tester.tap(find.text('Save'));
    await tester.pumpAndSettle();

    expect(find.text('Proyek berhasil ditambahkan!'), findsOneWidget);
    expect(find.text('Nama Proyek: Portfolio Mobile'), findsOneWidget);
    expect(
      find.text('Deskripsi: Aplikasi portofolio mobile dengan Flutter.'),
      findsOneWidget,
    );
    expect(find.text('Teknologi: Flutter, Dart'), findsOneWidget);
    expect(find.text('Tautan: https://example.com'), findsOneWidget);
  });

  testWidgets('kembali ke Home melalui drawer dari halaman form', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MyApp());

    await tester.tap(find.text('Tambah Proyek'));
    await tester.pumpAndSettle();
    await tester.tap(find.byTooltip('Open navigation menu'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Home'));
    await tester.pumpAndSettle();

    expect(find.text('Selamat datang di MyPortfolio Mobile!'), findsOneWidget);
  });
}
