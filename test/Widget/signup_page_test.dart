// test/signup_test.dart

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:grocery_shopping_list/presentation/pages/sign_in/signup.dart';
import 'package:mockito/mockito.dart';

import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MockNavigatorObserver extends Mock implements NavigatorObserver {}

void main() {
  testWidgets('Signup Page Widget Test', (WidgetTester tester) async {
    final mockObserver = MockNavigatorObserver();

    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp(
          home: Signup(),
          navigatorObservers: [mockObserver],
        ),
      ),
    );

    // Verify if the signup page is displayed
    expect(find.text('Create new account'), findsOneWidget);

    // Enter a username
    await tester.enterText(find.byType(TextFormField).at(0), 'testuser');
    expect(find.text('testuser'), findsOneWidget);

    // Enter a password
    await tester.enterText(find.byType(TextFormField).at(1), 'password123');
    expect(find.text('password123'), findsOneWidget);

    // Tap the signup button
    await tester.tap(find.text('SIGNUP'));
    await tester.pump();

    // Add more assertions as needed, e.g., verify navigation or error messages
  });
}
