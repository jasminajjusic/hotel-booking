import 'package:equatable/equatable.dart';
import 'hotel_model.dart';

abstract class HotelState extends Equatable {
  @override
  List<Object?> get props => [];
}

class HotelInitial extends HotelState {}

class HotelLoading extends HotelState {}

class HotelLoaded extends HotelState {
  final List<Hotel> hotels;

  HotelLoaded(this.hotels);

  @override
  List<Object?> get props => [hotels];
}

class HotelError extends HotelState {
  final String message;

  HotelError(this.message);

  @override
  List<Object?> get props => [message];
}
