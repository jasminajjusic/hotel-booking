class Profile {
  final String name;
  final DateTime? dateOfBirth;
  final String country;
  final String phoneNumber;

  Profile({
    required this.name,
    this.dateOfBirth,
    required this.country,
    required this.phoneNumber,
  });

  Profile copyWith({
    String? name,
    DateTime? dateOfBirth,
    String? country,
    String? phoneNumber,
  }) {
    return Profile(
      name: name ?? this.name,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      country: country ?? this.country,
      phoneNumber: phoneNumber ?? this.phoneNumber,
    );
  }

  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
      name: json['name'] ?? '',
      dateOfBirth:
          json['date_of_birth'] != null
              ? DateTime.tryParse(json['date_of_birth'])
              : null,
      country: json['country'] ?? '',
      phoneNumber: json['phone'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'date_of_birth': dateOfBirth?.toIso8601String(),
      'country': country,
      'phone': phoneNumber,
    };
  }
}
