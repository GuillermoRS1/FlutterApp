import 'package:flutter/material.dart';
import '../models/item.dart';
import '../services/DBService.dart';

/// Provider class for managing item state
class ItemProvider extends ChangeNotifier {
  final DBService _databaseService = DBService();
  List<Item> _items = [];
  bool _isLoading = false;
  String? _error;

  List<Item> get items => _items;
  bool get isLoading => _isLoading;
  String? get error => _error;

  /// Load all items from the database.
  Future<void> loadItems() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _items = await _databaseService.getItems();
    } catch (e) {
      _setError('Failed to load items: ${e.toString()}');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Adds a new item to the database.
  /// Returns true if the item was added successfully, false otherwise.
  Future<bool> addItem(String name, String description) async {
    if (_validateItem(name, description)) return false;

    try {
      final item = Item(name: name.trim(), description: description.trim());
      final id = await _databaseService.insertItem(item);
      _items.add(item.copyWith(id: id));
      _error = null;
      notifyListeners();
      return true;
    } catch (e) {
      _setError('Failed to add item: ${e.toString()}');
      return false;
    }
  }

  /// Updates an existing item.
  Future<bool> updateItem(int id, String name, String description) async {
    if (_validateItem(name, description)) return false;

    try {
      final item = Item(id: id, name: name.trim(), description: description.trim());
      await _databaseService.updateItem(item);
      final index = _items.indexWhere((element) => element.id == id);
      if (index != -1) {
        _items[index] = item;
      }
      _error = null;
      notifyListeners();
      return true;
    } catch (e) {
      _setError('Failed to update item: ${e.toString()}');
      return false;
    }
  }

  /// Deletes an item by its ID.
  Future<bool> deleteItem(int id) async {
    try {
      await _databaseService.deleteItem(id);
      _items.removeWhere((element) => element.id == id);
      _error = null;
      notifyListeners();
      return true;
    } catch (e) {
      _setError('Failed to delete item: ${e.toString()}');
      return false;
    }
  }

  /// Clears the error message.
  void clearError() {
    _error = null;
    notifyListeners();
  }

  /// Private method to set error messages.
  void _setError(String message) {
    _error = message;
    notifyListeners();
  }

  /// Validates item fields.
  bool _validateItem(String name, String description) {
    if (name.trim().isEmpty || description.trim().isEmpty) {
      _setError('Name and description cannot be empty');
      return true;
    }
    return false;
  }
}