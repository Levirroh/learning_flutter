class Item {
  final String id;
  final String name;
  final String userId;
  final DateTime createdAt;

  const Item({
    required this.id,
    required this.name,
    required this.userId,
    required this.createdAt,
  });

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      id: json['id'] as String,
      name: json['name'] as String,
      userId: json['user_id'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
    );
  }
}
