import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile/views/VotingResults.dart';

void main() {
  testWidgets('VotingResults widget', (widgetTester) async {
    //Przygotowujemy potrzebne dane
    final votingResultsView = VotingResultsPage();

    //Ładujemy widok do pamięci
    await widgetTester.pumpWidget(votingResultsView);

    // Oczekiwanie na odświeżenie widoku
    await widgetTester.pump();

    // Sprawdzenie, czy na ekranie wyświetlają się jakiekolwiek dane
    expect(find.byType(Text), findsWidgets);
  });
}