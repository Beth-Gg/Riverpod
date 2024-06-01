import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:grocery_shopping_list/models/lists_model.dart';
import '../repositories/lists_repository.dart';
import '../models/shops_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ListsNotifier extends StateNotifier<List<GroceryList>> {
  final ListRepository _ListRepository;

  ListsNotifier(this._ListRepository) : super([]);

  // Future<String> getToken() async {
  //   final SharedPreferences prefs = await SharedPreferences.getInstance();
  //   return prefs.getString('token');
  // }

  Future<void> fetchAllLists() async {
    try {
      final lists = await _ListRepository.fetchAllLists();
      state = lists;
    } catch (e) {
      // Handle error
    }
  }

  Future<void> addLists(String date, String content) async {
    try {
      final id = await _ListRepository.addList(date, content);
      final newList = GroceryList(id: id, date: date, content: content);
      state = [...state, newList];
    } catch (e) {
      // Handle error
    }
  }

  Future<void> editList(String id, String date, String content) async {
    try {
      await _ListRepository.editList(id, date, content);
      state = state
          .map((list) =>
              list.id == id ? GroceryList(id: id, date: date, content: content) : list)
          .toList();
    } catch (e) {
      // Handle error
    }
  }

  Future<void> deleteShop(String id) async {
    try {
      await _ListRepository.deleteList(id);
      state = state.where((list) => list.id != id).toList();
    } catch (e) {
      // Handle error
    }
  }
}
