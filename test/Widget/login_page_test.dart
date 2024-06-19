import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import '../../lib/presentation/pages/login/login.dart';
import 'package:grocery_shopping_list/services/login_service.dart';
import 'package:grocery_shopping_list/providers/login_provider.dart';

import 'loginScreen_test.mocks.mocks.dart';




// Generate the mock class using build_runner and mockito
@GenerateMocks([AuthService])


void main() {
  testWidgets('Login screen test', (WidgetTester tester) async {
    final mockAuthService = MockAuthService();

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          authoProvider.overrideWithValue(mockAuthService),
        ],
        child: MaterialApp(
          home: LoginScreen(),
        ),
      ),
    );

    // Find the username and password text fields
    final usernameField = find.byKey(const Key('usernameField'));
    final passwordField = find.byKey(const Key('passwordField'));

    // Enter text into the text fields
    await tester.enterText(usernameField, 'testuser');
    await tester.enterText(passwordField, 'testpassword');

    // Simulate login success
    when(mockAuthService.login('testuser', 'testpassword', any)).thenAnswer((_) async => 'token');

    // Tap the login button
    await tester.tap(find.text('LOGIN'));
    await tester.pump(); // Rebuild the widget after the state has changed

    // Verify that the login method was called with the correct parameters
    verify(mockAuthService.login('testuser', 'testpassword', any)).called(1);

    // Simulate login failure
    when(mockAuthService.login(any, any, any)).thenThrow(Exception('Login failed'));

    // Tap the login button
    await tester.tap(find.text('LOGIN'));
    await tester.pump(); // Rebuild the widget after the state has changed

    // Verify that the login method was called with the correct parameters
    verify(mockAuthService.login('testuser', 'testpassword', any)).called(1);

    // Verify that a SnackBar is shown
    expect(find.text('Login failed'), findsOneWidget);
  });
}
