import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';
part 'favorite_event.dart';
part 'favorite_state.dart';

// class FavoriteBloc extends Bloc<FavoriteEvent, FavoriteState> {
//   FavoriteBloc() : super(FavoriteInitial()) {
//     on<FavoriteEvent>((event, emit) {
//       // TODO: implement event handler
//     });
//   }
// }

// class FavoriteProvider with ChangeNotifier {
//   Set<int> _favoriteItems = {};

//   Set<int> get favoriteItems => _favoriteItems;

//   FavoriteProvider() {
//     _loadFavorites(); // โหลดค่า Favorite ที่บันทึกไว้
//   }

//   void toggleFavorite(int index) {
//     if (_favoriteItems.contains(index)) {
//       _favoriteItems.remove(index);
//     } else {
//       _favoriteItems.add(index);
//     }
//     notifyListeners();
//     _saveFavorites();
//   }

//   bool isFavorite(int index) {
//     return _favoriteItems.contains(index);
//   }

//   Future<void> _loadFavorites() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     List<String>? savedFavorites = prefs.getStringList('favorite_items');
//     if (savedFavorites != null) {
//       _favoriteItems = savedFavorites.map((e) => int.parse(e)).toSet();
//     }
//     notifyListeners();
//   }

//   Future<void> _saveFavorites() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     await prefs.setStringList(
//       'favorite_items',
//       _favoriteItems.map((e) => e.toString()).toList(),
//     );
//   }
// }

class FavoriteProvider with ChangeNotifier {
  Set<int> _favoriteItems = {};

  Set<int> get favoriteItems => _favoriteItems;

  FavoriteProvider() {
    _loadFavorites(); // โหลดค่า Favorite ที่บันทึกไว้
  }

  void toggleFavorite(int index) {
    if (_favoriteItems.contains(index)) {
      _favoriteItems.remove(index);
    } else {
      _favoriteItems.add(index);
    }
    notifyListeners();
    _saveFavorites();
  }

  bool isFavorite(int index) {
    return _favoriteItems.contains(index);
  }

  Future<void> _loadFavorites() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? savedFavorites = prefs.getStringList('favorite_items');
    if (savedFavorites != null) {
      _favoriteItems = savedFavorites.map((e) => int.parse(e)).toSet();
    }
    notifyListeners();
  }

  Future<void> _saveFavorites() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(
      'favorite_items',
      _favoriteItems.map((e) => e.toString()).toList(),
    );
  }
}
