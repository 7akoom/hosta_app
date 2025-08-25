class ProviderModel {
  final String id;
  final String name;
  final String email;
  final String phone;
  final String address;
  final String? image;
  final double rating;
  final double price;
  final String serviceId;
  final bool isActive;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String? description;
  final List<String>? specializations;
  final List<String>? languages;
  final Map<String, dynamic>? additionalInfo;

  const ProviderModel({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.address,
    this.image,
    required this.rating,
    required this.price,
    required this.serviceId,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
    this.description,
    this.specializations,
    this.languages,
    this.additionalInfo,
  });

  factory ProviderModel.fromJson(Map<String, dynamic> json) {
    return ProviderModel(
      id: json['id'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      phone: json['phone'] as String,
      address: json['address'] as String,
      image: json['image'] as String?,
      rating: (json['rating'] as num).toDouble(),
      price: (json['price'] as num).toDouble(),
      serviceId: json['service_id'] as String,
      isActive: json['is_active'] as bool,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
      description: json['description'] as String?,
      specializations: json['specializations'] != null
          ? List<String>.from(json['specializations'] as List)
          : null,
      languages: json['languages'] != null
          ? List<String>.from(json['languages'] as List)
          : null,
      additionalInfo: json['additional_info'] as Map<String, dynamic>?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'address': address,
      'image': image,
      'rating': rating,
      'price': price,
      'service_id': serviceId,
      'is_active': isActive,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'description': description,
      'specializations': specializations,
      'languages': languages,
      'additional_info': additionalInfo,
    };
  }

  ProviderModel copyWith({
    String? id,
    String? name,
    String? email,
    String? phone,
    String? address,
    String? image,
    double? rating,
    double? price,
    String? serviceId,
    bool? isActive,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? description,
    List<String>? specializations,
    List<String>? languages,
    Map<String, dynamic>? additionalInfo,
  }) {
    return ProviderModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      address: address ?? this.address,
      image: image ?? this.image,
      rating: rating ?? this.rating,
      price: price ?? this.price,
      serviceId: serviceId ?? this.serviceId,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      description: description ?? this.description,
      specializations: specializations ?? this.specializations,
      languages: languages ?? this.languages,
      additionalInfo: additionalInfo ?? this.additionalInfo,
    );
  }

  @override
  String toString() {
    return 'ProviderModel(id: $id, name: $name, email: $email, phone: $phone, address: $address, image: $image, rating: $rating, price: $price, serviceId: $serviceId, isActive: $isActive, createdAt: $createdAt, updatedAt: $updatedAt, description: $description, specializations: $specializations, languages: $languages, additionalInfo: $additionalInfo)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ProviderModel && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}
