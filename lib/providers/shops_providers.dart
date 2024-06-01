import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../repositories/shop_repositoriy.dart';
import '../controllers/shops_controllers.dart';
import '../models/shops_model.dart';

final shopRepositoryProvider = Provider<ShopRepository>((ref) {
  return ShopRepository();
});

final shopsProvider = StateNotifierProvider<ShopsNotifier, List<Shop>>((ref) {
  final repository = ref.watch(shopRepositoryProvider);
  return ShopsNotifier(repository);
});

final fetchShopsProvider = FutureProvider.autoDispose<List<Shop>>((ref) async {
  final shopsNotifier = ref.watch(shopsProvider.notifier);
  await shopsNotifier.fetchAllShops();
  return ref.watch(shopsProvider);
});


