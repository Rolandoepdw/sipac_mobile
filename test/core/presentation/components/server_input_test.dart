import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sipac_mobile_4/core/data/user_preferences.dart';
import 'package:sipac_mobile_4/core/presentation/components/server_input.dart';

void main() async {
  SharedPreferences.setMockInitialValues({});

  UserPreferences userPreferences = UserPreferences();
  await userPreferences.initUserPreferences();

  testWidgets('ServerInput Widget Test', (WidgetTester tester) async {
    // Build the widget
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: ServerInput(TextEditingController(),key: const Key('show_dialog_button')),
      ),
    ));

    // Tap the button to show the dialog
    await tester.tap(find.byKey(const Key('show_dialog_button')));
    await tester.pumpAndSettle();

    // Verify that the dialog is displayed
    expect(find.byType(AlertDialog), findsOneWidget);

    // Verify the presence of necessary widgets in the dialog
    expect(find.byIcon(Icons.dns_rounded), findsOneWidget);
    expect(find.text('Servidor'), findsOneWidget);
    expect(find.text('CANCELAR'), findsOneWidget);
    expect(find.text('GUARDAR'), findsOneWidget);

    // Enter text in the server field
    await tester.enterText(find.byType(TextField), 'example.com');
    await tester.pumpAndSettle();

    // Tap the "GUARDAR" button
    await tester.tap(find.text('GUARDAR'));
    await tester.pumpAndSettle();

    // Verify that the dialog is dismissed
    expect(find.byType(AlertDialog), findsNothing);

    // Verify that the user data is saved correctly
    expect(UserPreferences().userData, 'example.com');
  });
}
