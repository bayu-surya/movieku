
import 'package:movieku/data/api/api_service.dart';
import 'package:flutter/foundation.dart';
import 'package:movieku/data/model/movie_video.dart';
import 'package:movieku/utils/result_state.dart';

class MovieVideoProvider extends ChangeNotifier {

  final ApiService apiService;

  MovieVideoProvider({@required this.apiService});

  MovieVideo _movieVideo;
  String _message = '';
  ResultState _state;

  String get message => _message;

  MovieVideo get result => _movieVideo;

  ResultState get state => _state;

  Future<dynamic> fetchAllArticle(String id) async {
    try {
      _state = ResultState.Loading;
      notifyListeners();
      final data = await apiService.getListMovieVideo(id);
      if (data==null) {
        _state = ResultState.NoData;
        notifyListeners();
        return _message = 'Tidak ada data movie video';
      } else {
        _state = ResultState.HasData;
        notifyListeners();
        return _movieVideo = data;
      }
    } catch (e) {
      _state = ResultState.Error;
      notifyListeners();
      return _message = 'Error,\ntidak ada data movie video';
    }
  }
}