import 'package:ex_architectures/mvvm/entity.dart';

class MovieModel {
  final Movie movie;

  MovieModel({required this.movie});

  String get title {
    return this.movie.title;
  }

  String get poster {
    return this.movie.poster;
  }
}
