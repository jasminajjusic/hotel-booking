class Hotel {
  final String id;
  final String name;
  final String location;
  final String description;
  final String imageUrl;
  final double price;
  final double rating;
  final double latitude;
  final double longitude;
  final bool favorite;

  Hotel({
    required this.id,
    required this.name,
    required this.location,
    required this.description,
    required this.imageUrl,
    required this.price,
    required this.rating,
    required this.latitude,
    required this.longitude,
    this.favorite = false,
  });

  factory Hotel.fromJson(Map<String, dynamic> json) {
    return Hotel(
      id: json['id'],
      name: json['name'],
      location: json['location'],
      description: json['description'] ?? '',
      imageUrl: json['image_url'] ?? '',
      price: (json['price'] as num).toDouble(),
      rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
      latitude: (json['latitude'] as num?)?.toDouble() ?? 0.0,
      longitude: (json['longitude'] as num?)?.toDouble() ?? 0.0,
      favorite: json['favorite'] ?? false,
    );
  }

  Hotel copyWith({
    String? id,
    String? name,
    String? location,
    String? description,
    String? imageUrl,
    double? price,
    double? rating,
    double? latitude,
    double? longitude,
    bool? favorite,
  }) {
    return Hotel(
      id: id ?? this.id,
      name: name ?? this.name,
      location: location ?? this.location,
      description: description ?? this.description,
      imageUrl: imageUrl ?? this.imageUrl,
      price: price ?? this.price,
      rating: rating ?? this.rating,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      favorite: favorite ?? this.favorite,
    );
  }
}
