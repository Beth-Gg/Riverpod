import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:grocery_shopping_list/providers/lists_provider.dart';
import './list_dialogbox.dart';
import 'package:go_router/go_router.dart';
import '../../../providers/login_provider.dart';

class UserListPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final auth = ref.watch(authoProvider);
    final shopsNotifier = ref.watch(listsProvider.notifier);
    final asyncShops = ref.watch(listsProvider);

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
      floatingActionButton: TextButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => EditListDialog(
              onEdit: (date, content) {
                shopsNotifier.fetchAllLists();
                shopsNotifier.addLists(date, content);
                shopsNotifier.fetchAllLists();
              },
            ),
          );
        },
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(
            Colors.deepPurple,
          ),
        ),
        child: const Text(
          'Add a List',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: asyncShops.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: asyncShops.length,
              itemBuilder: (context, index) {
                final list = asyncShops[index];
                return Card(
                  margin: const EdgeInsets.all(8),
                  elevation: 4,
                  child: ListTile(
                    title: Text(list.date),
                    titleTextStyle: const TextStyle(fontSize: 20),
                    subtitle: Text(list.content),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) => EditListDialog(
                                shop: list,
                                onEdit: (date, content) {
                                  shopsNotifier.fetchAllLists();
                                  shopsNotifier.editList(
                                      list.id, date, content);
                                  shopsNotifier.fetchAllLists();
                                },
                              ),
                            );
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () {
                            shopsNotifier.fetchAllLists();
                            shopsNotifier.deleteShop(list.id);
                            shopsNotifier.fetchAllLists();
                            // asyncShops = fetchListsProvider;
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
