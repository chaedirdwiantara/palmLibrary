class Book {
  final int id;
  final String title;
  final String author;
  final String imageUrl;
  bool isLiked;

  Book({
    required this.id,
    required this.title,
    required this.author,
    required this.imageUrl,
    this.isLiked = false,
  });

  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      id: json['id'],
      title: json['title'],
      author: json['authors'].isNotEmpty
          ? json['authors'][0]['name']
          : 'Unknown Author',
      imageUrl:
          json['formats']['image/jpeg'] ?? 'https://via.placeholder.com/150',
    );
  }
}
