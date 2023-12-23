part of 'review_bloc.dart';

sealed class ReviewState extends Equatable {
  const ReviewState();

  @override
  List<Object> get props => [];
}

class ReviewLoadingState extends ReviewState {
@override
List<Object> get props => [];
}

class ReviewLoadedState extends ReviewState {
  final List<Review> reviews;

  const ReviewLoadedState(this.reviews);
  @override
  List<Object> get props => [reviews];
}

class ReviewErrorState extends ReviewState {
  final String error;

  const ReviewErrorState(this.error);
  @override
  List<Object> get props => [error];
}

