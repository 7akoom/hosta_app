class FeedbackModel {
  final String id;
  final String providerId;
  final String bookingId;
  final int rating;
  final String? comment;
  final DateTime createdAt;

  FeedbackModel({
    required this.id,
    required this.providerId,
    required this.bookingId,
    required this.rating,
    this.comment,
    required this.createdAt,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'provider_id': providerId,
      'booking_id': bookingId,
      'rating': rating,
      'comment': comment,
      'created_at': createdAt.toIso8601String(),
    };
  }

  factory FeedbackModel.fromJson(Map<String, dynamic> json) {
    return FeedbackModel(
      id: json['id'],
      providerId: json['provider_id'],
      bookingId: json['booking_id'],
      rating: json['rating'],
      comment: json['comment'],
      createdAt: DateTime.parse(json['created_at']),
    );
  }
}
