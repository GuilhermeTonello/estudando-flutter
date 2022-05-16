import 'package:alura_bytebank/components/feature_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:alura_bytebank/screens/dashboard.dart';

import '../utils/predicates.dart';

void main() {

  testWidgets(
      'Deve apresentar a imagem principal quando o Dashboard for aberto',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: Dashboard()));
    final Finder mainImage = find.byType(Image);
    expect(mainImage, findsOneWidget);
  });

  testWidgets('Deve encontrar a funcionalidade de transferir para um contato',
      (tester) async {
    await tester.pumpWidget(const MaterialApp(home: Dashboard()));

    final Finder transactionFeatureWithIcon = find.widgetWithIcon(FeatureItem, Icons.monetization_on);
    final Finder transactionFeatureWithText = find.widgetWithText(FeatureItem, 'Transfer');

    expect(transactionFeatureWithIcon, findsOneWidget);
    expect(transactionFeatureWithText, findsOneWidget);
  });

  testWidgets('Deve encontrar a funcionalidade da lista de transferências',
      (tester) async {
    await tester.pumpWidget(const MaterialApp(home: Dashboard()));

    final Finder transactionsFeedFeature = find.byWidgetPredicate(
      (widget) => featureItemMatcher(widget, 'Transactions feed', Icons.description)
    );

    expect(transactionsFeedFeature, findsOneWidget);
  });

}
