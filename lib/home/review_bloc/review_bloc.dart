
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

import '../../models/review_model.dart';
import 'package:movie_booking_app/core/respository/review_respository.dart';

part 'review_event.dart';
part 'review_state.dart';

class ReviewBloc extends Bloc<ReviewEvent, ReviewState> {
  final ReviewRespository _reviewRespository;
  ReviewBloc(this._reviewRespository) : super(ReviewLoadingState()) {
    on<ReviewEvent>((event, emit) async{
      emit(ReviewLoadingState());
      try {
        final reviews = await _reviewRespository.getReview();
        emit(ReviewLoadedState(reviews));
      }
      catch (e) {
        emit(ReviewErrorState(e.toString()));
      }
    });

    on<UpdateLoadReviewEvent>((event,emit) async{
      emit(ReviewLoadingState());
      try {
        final reviews = await _reviewRespository.postReviews(event.reviews, event.rating, event.context);
        emit(ReviewLoadedState(reviews));
      }
      catch (e) {
        emit(ReviewErrorState(e.toString()));
      }
    });
  }
}
