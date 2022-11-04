import 'package:ex_architectures/mvvm/entity.dart';
import 'package:ex_architectures/mvvm/api.dart';
import 'package:ex_architectures/mvvm/model.dart';
import 'package:flutter/material.dart';

/// https://github.com/flutter-devs/flutter_mvvm_demo
class ExViewModel extends ChangeNotifier {
  List<Movie> movies = [];

  Future<void> fetchMovies(String keyword) async {
    final results = await Webservice().fetchMovies(keyword);
    this.movies = results.map((MovieModel item) => item.movie).toList();

    print(this.movies);
    notifyListeners();
  }
}
