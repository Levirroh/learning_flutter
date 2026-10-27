class Event {
  final String title;
  final String description;
  final String location;
  final String category;
  final DateTime date;
  bool registered;

  Event({
    required this.title,
    required this.description,
    required this.location,
    required this.category,
    required this.date,
    this.registered = false,
  });

  String get formattedDate {
    final day = date.day.toString().padLeft(2, '0');
    final month = date.month.toString().padLeft(2, '0');
    return "$day/$month/${date.year}";
  }
}
