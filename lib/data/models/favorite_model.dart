class FavoriteModel {
  final String id;
  final String providerId;
  final String providerName;
  final String? providerImage;
  final String serviceTitle;
  final double rating;
  final DateTime createdAt;

  FavoriteModel({
    required this.id,
    required this.providerId,
    required this.providerName,
    this.providerImage,
    required this.serviceTitle,
    required this.rating,
    required this.createdAt,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'provider_id': providerId,
      'provider_name': providerName,
      'provider_image': providerImage,
      'service_title': serviceTitle,
      'rating': rating,
      'created_at': createdAt.toIso8601String(),
    };
  }

  factory FavoriteModel.fromJson(Map<String, dynamic> json) {
    return FavoriteModel(
      id: json['id'],
      providerId: json['provider_id'],
      providerName: json['provider_name'],
      providerImage: json['provider_image'],
      serviceTitle: json['service_title'],
      rating: json['rating'].toDouble(),
      createdAt: DateTime.parse(json['created_at']),
    );
  }
}
