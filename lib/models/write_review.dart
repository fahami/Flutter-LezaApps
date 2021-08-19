import 'customer_reviews.dart';

class WriteReview {
  bool? error;
  String? message;
  List<CustomerReviews>? customerReviews;

  WriteReview({this.error, this.message, this.customerReviews});

  factory WriteReview.fromJson(Map<String, dynamic> json) => WriteReview(
        error: json['error'] as bool?,
        message: json['message'] as String?,
        customerReviews: (json['customerReviews'] as List<dynamic>?)
            ?.map((e) => CustomerReviews.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        'error': error,
        'message': message,
        'customerReviews': customerReviews?.map((e) => e.toJson()).toList(),
      };
}
