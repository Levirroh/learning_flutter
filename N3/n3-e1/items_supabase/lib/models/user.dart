class User {
  final String id;
  final String username;
  final String name;
  final String createdAt;
  final String email;

  const User({
    required this.name,
    required this.id,
    required this.username,
    required this.createdAt,
    required this.email,
  });
}
