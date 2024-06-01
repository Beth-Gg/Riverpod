class Shop {
  final String id;
  final String name;
  final String items;

  Shop({required this.id, required this.name, required this.items});

  factory Shop.fromJson(Map<String, dynamic> json) {
    return Shop(
      id: json['id'],
      name: json['name'],
      items: json['items'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'items': items,
    };
  }
}
