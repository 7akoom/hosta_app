class ServiceModel {
  final String id;
  final String name;
  final String description;
  final double price;
  final String duration;
  final double rating;
  final String categoryId;
  final bool isActive;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String? image;
  final List<String>? features;
  final Map<String, dynamic>? additionalInfo;

  const ServiceModel({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.duration,
    required this.rating,
    required this.categoryId,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
    this.image,
    this.features,
    this.additionalInfo,
  });

  factory ServiceModel.fromJson(Map<String, dynamic> json) {
    return ServiceModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      price: (json['price'] ?? 0.0).toDouble(),
      duration: json['duration'] ?? '',
      rating: (json['rating'] ?? 0.0).toDouble(),
      categoryId: json['category_id'] ?? '',
      isActive: json['is_active'] ?? true,
      createdAt: DateTime.parse(json['created_at'] ?? DateTime.now().toIso8601String()),
      updatedAt: DateTime.parse(json['updated_at'] ?? DateTime.now().toIso8601String()),
      image: json['image'],
      features: json['features'] != null 
          ? List<String>.from(json['features'])
          : null,
      additionalInfo: json['additional_info'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'price': price,
      'duration': duration,
      'rating': rating,
      'category_id': categoryId,
      'is_active': isActive,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'image': image,
      'features': features,
      'additional_info': additionalInfo,
    };
  }

  ServiceModel copyWith({
    String? id,
    String? name,
    String? description,
    double? price,
    String? duration,
    double? rating,
    String? categoryId,
    bool? isActive,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? image,
    List<String>? features,
    Map<String, dynamic>? additionalInfo,
  }) {
    return ServiceModel(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      price: price ?? this.price,
      duration: duration ?? this.duration,
      rating: rating ?? this.rating,
      categoryId: categoryId ?? this.categoryId,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      image: image ?? this.image,
      features: features ?? this.features,
      additionalInfo: additionalInfo ?? this.additionalInfo,
    );
  }

  @override
  String toString() {
    return 'ServiceModel(id: $id, name: $name, price: $price, categoryId: $categoryId)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ServiceModel && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
} 