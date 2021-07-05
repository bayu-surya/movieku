
import 'package:movieku/data/api/api_service.dart';
import 'package:movieku/data/model/detail_movie.dart';
import 'package:flutter/foundation.dart';
import 'package:movieku/utils/result_state.dart';

class DetailMovieProvider extends ChangeNotifier {

  final ApiService apiService;

  DetailMovieProvider({@required this.apiService});

  DetailMovie _detailMovie;
  String _message = '';
  ResultState _state;

  String get message => _message;

  DetailMovie get result => _detailMovie;

  ResultState get state => _state;

  Future<dynamic> fetchAllArticle(String id) async {
    try {
      _state = ResultState.Loading;
      notifyListeners();
      final data = await apiService.getDetailMovie(id);
      if (data==null) {
        _state = ResultState.NoData;
        notifyListeners();
        return _message = 'Tidak ada data detail movie';
      } else {
        _state = ResultState.HasData;
        notifyListeners();
        return _detailMovie = data;
      }
    } catch (e) {
      _state = ResultState.Error;
      notifyListeners();
      return _message = 'Error,\ntidak ada data detail movie';
    }
  }
}