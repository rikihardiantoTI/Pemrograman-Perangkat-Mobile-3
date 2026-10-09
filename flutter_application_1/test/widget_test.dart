// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

import 'package:flutter_application_1/main.dart';
import 'package:flutter_application_1/providers/cart_provider.dart';

void main() {
  testWidgets('NusaBookstore app loads and can add a book to cart', (WidgetTester tester) async {
    await tester.pumpWidget(
      ChangeNotifierProvider(
        create: (_) => CartProvider(),
        child: const NusaBookstoreApp(),
      ),
    );

    expect(find.text('NusaBookstore'), findsOneWidget);
    expect(find.text('Bumi Manusia'), findsOneWidget);

    await tester.tap(find.text('Beli').first);
    await tester.pump();

    expect(find.textContaining('ditambahkan ke keranjang'), findsOneWidget);
  });
}
