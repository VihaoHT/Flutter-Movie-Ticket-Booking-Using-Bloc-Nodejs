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
class LoadMovieAdminEvent extends MovieEvent{
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

class UpdateMovieEvent extends MovieEvent{
  final String title;
  final String release_date;
  final String duration;
  final String description;
  final String movieId;
  final BuildContext context;

  const UpdateMovieEvent({required this.title, required this.release_date, required this.duration, required this.description, required this.movieId, required this.context});


  @override
  List<Object> get props => [title,release_date,duration,description,context,movieId];
}

class UpdateCategoryMovieEvent extends MovieEvent{
  final List<String> category;
  final String movieId;
  final BuildContext context;

  const UpdateCategoryMovieEvent({required this.category, required this.movieId, required this.context});



  @override
  List<Object> get props => [category,context,movieId];
}

class UpdateActorMovieEvent extends MovieEvent{
  final List<Object> actor;
  final String movieId;
  final BuildContext context;

  const UpdateActorMovieEvent({required this.actor, required this.movieId, required this.context});





  @override
  List<Object> get props => [actor,context,movieId];
}

class DeleteMovieEvent extends MovieEvent{
  final String movieId;
  final BuildContext context;

  const DeleteMovieEvent({required this.movieId, required this.context});
  @override
  List<Object> get props => [context,movieId];
}

class SearchAdminMovieEvent extends MovieEvent{
  final String? title;

  const SearchAdminMovieEvent({required this.title});


  @override
  List<Object> get props => [title!];
}