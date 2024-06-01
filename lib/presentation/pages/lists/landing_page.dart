import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../providers/bottom_navigation_provider.dart';
import './user_lists.dart';
import './user_shop_page2.dart';

class NavigationPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedIndex = ref.watch(bottomNavigationBarProvider);

    return Scaffold(
      body: IndexedStack(
        index: selectedIndex,
        children: [
          UserListPage(),
          UserShopPage()        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        onTap: (currentIndex) {
          ref.read(bottomNavigationBarProvider.notifier).state = currentIndex;
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.trolley),
            label: 'Shopping lists',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopify_outlined),
            label: 'Shops',
          ),
        ],
      ),
    );
  }
}
