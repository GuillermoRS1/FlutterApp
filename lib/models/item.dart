/// Item model class representing the data structure.
class Item {
  final int? id;
  final String name;
  final String description;

  Item({
    this.id,
    required this.name,
    required this.description,
  });

  /// Convert Item to Map for database operations.
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
    };
  }

  /// Create Item from Map.
  factory Item.fromMap(Map<String, dynamic> map) {
    return Item(
      id: map['id'],
      name: map['name'],
      description: map['description'],
    );
  }

  /// Create a copy of Item with updated fields.
  Item copyWith({
    int? id,
    String? name,
    String? description,
  }) {
    return Item(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
    );
  }
}