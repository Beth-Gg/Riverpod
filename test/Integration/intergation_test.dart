import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:grocery_shopping_list/controllers/shops_controllers.dart';
import 'package:grocery_shopping_list/models/shops_model.dart';
import 'package:grocery_shopping_list/presentation/pages/lists/user_shop_page2.dart';
import 'package:grocery_shopping_list/providers/authProvider.dart';
import 'package:grocery_shopping_list/providers/shops_providers.dart';
import 'package:grocery_shopping_list/repositories/shop_repositoriy.dart';
import 'package:mockito/mockito.dart';
import 'package:riverpod/src/framework.dart';

import '../Widget/user_shop_page_test.dart';

// Mock classes
class MockAuthProvider extends Mock implements AuthProvider {
  logout() {}
}
class MockShopRepository extends Mock implements ShopRepository {}

void main() {
  testWidgets('Integration Test: UserShopPage', (WidgetTester tester) async {
    // Mock dependencies
    final mockAuthProvider = MockAuthProvider();
    final mockShopRepository = MockShopRepository();

    // Mock data
    final mockShops = [
      Shop(id: '1', name: 'Shop 1', items: 'Items 1, 2, 3'),
      Shop(id: '2', name: 'Shop 2', items: 'Items 4, 5, 6'),
    ];

    // Build the widget tree
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          authProvider.overrideWith(Provider((ref) => mockAuthProvider) as Create<AuthState, ProviderRef<AuthState>>),
          shopRepositoryProvider.overrideWithProvider(
            Provider((ref) => mockShopRepository)
          ),
        ],
        child: MaterialApp(
          home: UserShopPage(),
        ),
      ),
    );

    // Verify that the app bar title is correct
    expect(find.text('Shemeta Shopping'), findsOneWidget);

    // Verify that the shop items are displayed correctly
    expect(find.text('Shop 1'), findsOneWidget);
    expect(find.text('Items 1, 2, 3'), findsOneWidget);
    expect(find.text('Shop 2'), findsOneWidget);
    expect(find.text('Items 4, 5, 6'), findsOneWidget);

    // Simulate user interaction (e.g., tap a button)
    await tester.tap(find.text('Logout'));
    await tester.pump();

    // Verify that the logout action is triggered
    verify(mockAuthProvider.logout()).called(1);
  });
}
