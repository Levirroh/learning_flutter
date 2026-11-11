class Item {
  final int id;
  final String name;
  final String userId;
  final DateTime createdAt;

  const Item({
    required this.name,
    required this.id,
    required this.userId,
    required this.createdAt,
  });
}
