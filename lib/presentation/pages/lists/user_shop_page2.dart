import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:grocery_shopping_list/providers/authProvider.dart';
import 'package:grocery_shopping_list/repositories/shop_repositoriy.dart';
import '../../../models/shops_model.dart';
import '../../../providers/shops_providers.dart';
import 'package:go_router/go_router.dart';
import '../../../main.dart';
import '../../../providers/login_provider.dart';

class UserShopPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final auth = ref.watch(authoProvider);
    final shops = ref.watch(shopsProvider);
    final shopsNotifier = ref.watch(shopsProvider.notifier);
    final asyncShops = ref.watch(fetchShopsProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text('Shemeta Shopping'),
        backgroundColor: Color.fromARGB(255, 124, 118, 207),
        actions: [
          TextButton(
            onPressed: () {
              auth.logout();
              context.go('/login');
            },
            child: const Text(
              'Logout',
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
      body: asyncShops.when(
        data: (shops) {
          return ListView.builder(
            itemCount: shops.length,
            itemBuilder: (context, index) {
              final shop = shops[index];
              return Card(
                margin: EdgeInsets.all(8),
                elevation: 4,
                child: ListTile(
                  title: Text(shop.name),
                  subtitle: Text(shop.items),
                ),
              );
            },
          );
        },
        loading: () => Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) =>
            Center(child: Text('Failed to load shops')),
      ),
    );
  }
}
