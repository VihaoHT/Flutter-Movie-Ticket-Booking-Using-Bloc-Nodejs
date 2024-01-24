part of 'movie_bloc.dart';

sealed class MovieEvent extends Equatable {
  const MovieEvent();

  @override
  List<Object> get props => [];
}


class LoadMovieEvent extends MovieEvent{
   @override
  List<Object> get props => [];
}

class PostNewMovieEvent extends MovieEvent{
  final File image;
  final File video;
  final String title;
  final String release_date;
  final String duration;
  final  List<String> category;
  final List<String> actor;
  final String description;
  final BuildContext context;

  const PostNewMovieEvent({required this.context,required this.image, required this.video, required this.title, required this.release_date, required this.duration, required this.category, required this.actor, required this.description});

  @override
  List<Object> get props => [image,video,title,release_date,duration,category,actor,description,context];
}

class UpdateStatusMovieEvent extends MovieEvent{
  final bool status;
  final String movieId;
  final BuildContext context;

  const UpdateStatusMovieEvent({required this.status, required this.movieId, required this.context});
  @override
  List<Object> get props => [status,movieId,context];
}