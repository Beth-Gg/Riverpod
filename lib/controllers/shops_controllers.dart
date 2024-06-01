import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../repositories/shop_repositoriy.dart';
import '../models/shops_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ShopsNotifier extends StateNotifier<List<Shop>> {
  final ShopRepository _shopRepository;

  ShopsNotifier(this._shopRepository) : super([]);

  // Future<String> getToken() async {
  //   final SharedPreferences prefs = await SharedPreferences.getInstance();
  //   return prefs.getString('token');
  // }

  Future<void> fetchAllShops() async {
    try {
      final shops = await _shopRepository.fetchAllShops();
      state = shops;
    } catch (e) {
      // Handle error
    }
  }

  Future<void> addShop(String name, String items) async {
    try {
      final id = await _shopRepository.addShop(name, items);
      final newShop = Shop(id: id, name: name, items: items);
      state = [...state, newShop];
    } catch (e) {
      // Handle error
    }
  }

  Future<void> editShop(String id, String name, String items) async {
    try {
      await _shopRepository.editShop(id, name, items);
      state = state
          .map((shop) =>
              shop.id == id ? Shop(id: id, name: name, items: items) : shop)
          .toList();
    } catch (e) {
      // Handle error
    }
  }

  Future<void> deleteShop(String id) async {
    try {
      await _shopRepository.deleteShop(id);
      state = state.where((shop) => shop.id != id).toList();
    } catch (e) {
      // Handle error
    }
  }
}
