import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sipac_mobile_4/core/data/user_preferences.dart';
import 'package:sipac_mobile_4/core/presentation/pages/login/login_page.dart';
import 'package:sipac_mobile_4/main.dart' as app;

void main() async {
  // *** Remove dependencies from main before running the test ***
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  SharedPreferences.setMockInitialValues({});

  group('Login test', () {
    testWidgets('Verify login with correct credentials',
        (tester) async {
      app.main();
      await tester.pumpAndSettle();

      // Enter text in user and password field
      await tester.enterText(find.byType(TextFormField).at(0), 'admin');
      await tester.enterText(find.byType(TextFormField).at(1), '1234');

      // Tap the button to show the dialog
      await tester.tap(find.byType(FloatingActionButton));
      await tester.pumpAndSettle();

      // Verify that the dialog is displayed
      expect(find.byType(AlertDialog), findsOneWidget);

      // Verify the presence of necessary widgets in the dialog
      expect(find.byIcon(Icons.dns_rounded), findsWidgets);
      expect(find.text('Servidor'), findsOneWidget);
      expect(find.text('CANCELAR'), findsOneWidget);
      expect(find.text('GUARDAR'), findsOneWidget);

      // Enter text in the server field
      await tester.enterText(find.byType(TextFormField).at(2), '10.8.121.150');
      await tester.pumpAndSettle();

      // Tap the "GUARDAR" button
      await tester.tap(find.text('GUARDAR'));
      await tester.pumpAndSettle();

      // Verify that the user data is saved correctly
      expect(UserPreferences().userData, '10.8.121.150');

      // Verify that the dialog is dismissed
      expect(find.byType(AlertDialog), findsNothing);

      // Tap login button
      await tester.tap(find.text('Acceder'));

      // Verify that the user data is saved correctly
      expect(UserPreferences().userData,
          '{"token":"","server":"10.8.121.150","name":"admin","password":"1234"}');
    });

    testWidgets('Verify login with incorrect credentials',
        (tester) async {
      app.main();
      await tester.pumpAndSettle();

      // Enter text in user and password field
      await tester.enterText(find.byType(TextFormField).at(0), '');
      await tester.enterText(find.byType(TextFormField).at(1), '');

      // Tap the button to show the dialog
      await tester.tap(find.byType(FloatingActionButton));
      await tester.pumpAndSettle();

      // Verify that the dialog is displayed
      expect(find.byType(AlertDialog), findsOneWidget);

      // Verify the presence of necessary widgets in the dialog
      expect(find.byIcon(Icons.dns_rounded), findsWidgets);
      expect(find.text('Servidor'), findsOneWidget);
      expect(find.text('CANCELAR'), findsOneWidget);
      expect(find.text('GUARDAR'), findsOneWidget);

      // Enter text in the server field
      await tester.enterText(find.byType(TextFormField).at(2), '');
      await tester.pumpAndSettle();

      // Tap the "GUARDAR" button
      await tester.tap(find.text('GUARDAR'));
      await tester.pumpAndSettle();

      // Verify that the dialog is dismissed
      expect(find.byType(AlertDialog), findsNothing);

      // Tap login button
      await tester.tap(find.text('Acceder'));
      await tester.pumpAndSettle();

      // Verify the current page
      expect(find.byType(LoginPage), findsOneWidget);
    });
  });
}
