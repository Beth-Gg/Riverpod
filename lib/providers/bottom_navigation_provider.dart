import 'package:flutter_riverpod/flutter_riverpod.dart';

// Create a StateProvider to manage the current index of the BottomNavigationBar
final bottomNavigationBarProvider = StateProvider<int>((ref) {
  return 0; // Default selected index
});
