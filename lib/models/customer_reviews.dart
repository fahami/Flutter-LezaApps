class CustomerReviews {
  String name;
  String review;
  String date;

  CustomerReviews(
      {required this.name, required this.review, required this.date});

  factory CustomerReviews.fromJson(Map<String, dynamic> json) =>
      CustomerReviews(
        name: json['name'] as String,
        review: json['review'] as String,
        date: json['date'] as String,
      );

  Map<String, dynamic> toJson() => {
        'name': name,
        'review': review,
        'date': date,
      };
}
