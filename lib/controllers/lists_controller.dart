import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:grocery_shopping_list/models/lists_model.dart';
import '../repositories/lists_repository.dart';

class ListsNotifier extends StateNotifier<List<GroceryList>> {
  final ListRepository repository;

  ListsNotifier(this.repository) : super([]);

  Future<void> fetchAllLists() async {
    final lists = await repository.fetchAllLists();
    state = lists;
  }

  Future<void> addLists(String date, String content) async {
    final newListId = await repository.addList(date, content);
    final newList = GroceryList(id: newListId, date: date, content: content);
    state = [...state, newList];
  }

  Future<void> editList(String id, String date, String content) async {
    await repository.editList(id, date, content);
    state = [
      for (final list in state)
        if (list.id == id) GroceryList(id: id, date: date, content: content) else list
    ];
  }

  Future<void> deleteShop(String id) async {
    await repository.deleteList(id);
    state = state.where((list) => list.id != id).toList();
  }
}
