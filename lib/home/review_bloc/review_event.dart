part of 'review_bloc.dart';

sealed class ReviewEvent extends Equatable {
  const ReviewEvent();

  @override
  List<Object> get props => [];
}
class LoadReviewEvent extends ReviewEvent{
  @override
  List<Object> get props => [];
}

class UpdateLoadReviewEvent extends ReviewEvent{
  final String reviews;
  final double rating;

  const UpdateLoadReviewEvent({required this.reviews, required this.rating});
  @override
  List<Object> get props => [reviews,rating.toDouble()];
}