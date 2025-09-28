class BookingState {
  final bool loading;
  final String? error;
  final bool success;
  final List<Map<String, dynamic>> bookings;

  BookingState({
    this.loading = false,
    this.error,
    this.success = false,
    this.bookings = const [],
  });

  BookingState copyWith({
    bool? loading,
    String? error,
    bool? success,
    List<Map<String, dynamic>>? bookings,
  }) {
    return BookingState(
      loading: loading ?? this.loading,
      error: error,
      success: success ?? this.success,
      bookings: bookings ?? this.bookings,
    );
  }
}
