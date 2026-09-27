import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:movie_list/main.dart';

void main() {
  testWidgets('Home list renders and opens Details on tap', (tester) async {
    await tester.pumpWidget(const MovieWatchlistApp());

    expect(find.text('Trending Now'), findsOneWidget);
    expect(find.text('Inception'), findsWidgets);

    await tester.tap(find.text('Inception').first);
    await tester.pumpAndSettle();

    expect(find.text('Cast'), findsOneWidget);
    expect(find.text('Synopsis'), findsOneWidget);
  });
}
