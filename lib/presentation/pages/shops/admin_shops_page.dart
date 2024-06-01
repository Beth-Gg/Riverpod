import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:grocery_shopping_list/providers/authProvider.dart';
import 'package:grocery_shopping_list/repositories/shop_repositoriy.dart';
import '../../../models/shops_model.dart';
import '../../../providers/shops_providers.dart';
import 'shops_dialog.dart';
import 'package:go_router/go_router.dart';
import '../../../providers/login_provider.dart';

class AdminShopPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final auth = ref.watch(authoProvider);
    final shops = ref.watch(shopsProvider);
    final shopsNotifier = ref.watch(shopsProvider.notifier);
    final asyncShops = ref.watch(fetchShopsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Shemeta Shopping'),
        backgroundColor: Colors.deepPurple,
        actions: [
          IconButton(
            onPressed: () {
              auth.logout();
              context.go('/login');
            },
            icon: const Icon(Icons.logout),
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
                margin: const EdgeInsets.all(8),
                elevation: 4,
                child: ListTile(
                  title: Text(shop.name),
                  subtitle: Text(shop.items),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) => EditShopDialog(
                              shop: shop,
                              onEdit: (name, items) {
                                shopsNotifier.fetchAllShops();
                                shopsNotifier.editShop(shop.id, name, items);
                                shopsNotifier.fetchAllShops();
                              },
                            ),
                          );
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () {
                          shopsNotifier.fetchAllShops();
                          shopsNotifier.deleteShop(shop.id);
                          shopsNotifier.fetchAllShops();
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) =>
            const Center(child: Text('Failed to load shops')),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Center(
          child: TextButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => EditShopDialog(
                  onEdit: (name, items) {
                    shopsNotifier.fetchAllShops();
                    shopsNotifier.addShop(name, items);
                    shopsNotifier.fetchAllShops();
                  },
                ),
              );
            },
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(
                const Color.fromARGB(255, 110, 112, 240),
              ),
            ),
            child: const Text(
              'Add a shop',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
