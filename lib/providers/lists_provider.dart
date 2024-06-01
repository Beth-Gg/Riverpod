import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:grocery_shopping_list/controllers/lists_controller.dart';
import 'package:grocery_shopping_list/models/lists_model.dart';
import '../repositories/lists_repository.dart';

final listRepositoryProvider = Provider<ListRepository>((ref) {
  return ListRepository();
});

final listsProvider = StateNotifierProvider<ListsNotifier, List<GroceryList>>((ref) {
  final listrepository = ref.watch(listRepositoryProvider);
  return ListsNotifier(listrepository)..fetchAllLists(); 
});

final fetchListsProvider = FutureProvider<List<GroceryList>>((ref) async {
  final listsNotifier = ref.watch(listsProvider.notifier);
  await listsNotifier.fetchAllLists();
  return ref.watch(listsProvider);
});




