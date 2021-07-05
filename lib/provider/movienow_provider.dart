
import 'package:movieku/data/api/api_service.dart';
import 'package:movieku/data/model/movie_now.dart';
import 'package:movieku/data/model/movie_popular.dart';
import 'package:flutter/foundation.dart';
import 'package:movieku/utils/result_state.dart';

class MovieNowProvider extends ChangeNotifier {

  final ApiService apiService;

  MovieNowProvider({@required this.apiService}) {
    _fetchAllArticle();
  }

  MovieNow _movieNow;
  String _message = '';
  ResultState _state;

  String get message => _message;

  MovieNow get result => _movieNow;

  ResultState get state => _state;

  Future<dynamic> _fetchAllArticle() async {
    try {
      _state = ResultState.Loading;
      notifyListeners();
      final data = await apiService.getListMovieNow();
      if (data.results.isEmpty) {
        _state = ResultState.NoData;
        notifyListeners();
        return _message = 'Tidak ada data list movie now playing';
      } else {
        _state = ResultState.HasData;
        notifyListeners();
        return _movieNow = data;
      }
    } catch (e) {
      _state = ResultState.Error;
      notifyListeners();
      return _message = 'Error,\ntidak ada data list movie now playing.';
    }
  }
}