import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../providers/shops_providers.dart';
import 'package:go_router/go_router.dart';
import '../../../providers/login_provider.dart';

class UserShopPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final auth = ref.watch(authoProvider);
    // final shops = ref.watch(shopsProvider);
    // final shopsNotifier = ref.watch(shopsProvider.notifier);
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
                ),
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) =>
            const Center(child: Text('Failed to load shops')),
      ),
    );
  }
}
