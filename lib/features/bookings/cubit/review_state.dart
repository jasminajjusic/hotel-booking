import 'package:equatable/equatable.dart';

class Review {
  final String id;
  final String hotelId;
  final String profileId;
  final String profileName;
  final double rating;
  final String comment;
  final DateTime createdAt;

  Review({
    required this.id,
    required this.hotelId,
    required this.profileId,
    required this.profileName,
    required this.rating,
    required this.comment,
    required this.createdAt,
  });

  factory Review.fromMap(Map<String, dynamic> map) {
    return Review(
      id: map['id'],
      hotelId: map['hotel_id'],
      profileId: map['profile_id'],
      profileName: map['profile_name'] ?? 'User',
      rating: (map['rating'] as num).toDouble(),
      comment: map['comment'] ?? '',
      createdAt: DateTime.parse(map['created_at']),
    );
  }
}

abstract class ReviewState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ReviewInitial extends ReviewState {}

class ReviewLoading extends ReviewState {}

class ReviewLoaded extends ReviewState {
  final List<Review> reviews;

  ReviewLoaded(this.reviews);

  @override
  List<Object?> get props => [reviews];
}

class ReviewError extends ReviewState {
  final String message;

  ReviewError(this.message);

  @override
  List<Object?> get props => [message];
}
