import 'package:dio/dio.dart';
import 'package:flutter_arts_demos_app/application.dart';
import 'package:flutter_arts_demos_app/bloc/bloc_provider.dart';
import 'package:flutter_arts_demos_app/colsed/fuli_model.dart';
import 'package:rxdart/rxdart.dart';

class FuliBloc extends BaseBloc {
  List<FuliModel> _models = [];
  int _page = 1;

  List<FuliModel> get fuLi => _models;

  int get page => _page;

  BehaviorSubject<List<FuliModel>> _controller = BehaviorSubject();

  Observable<List<FuliModel>> get stream => Observable(_controller.stream);

  increasePage() => _page++;

  refreshFuli(List<FuliModel> models) {
    _models.clear();
    _models.addAll(models);
    _controller.add(_models);
  }

  loadMoreFuli(List<FuliModel> models) {
    _models.addAll(models);
    _controller.add(_models);
  }

  Future<List<FuliModel>> requestFuli(int page) async {
    Response resp = await Application.http.getRequest('http://adr.meizitu.net/wp-json/wp/v2/posts',
        params: {'page': page, 'per_page': 10}, callback: (msg) => print(msg));
    return resp != null ? FuliModel.fromMapList(resp.data) : [];
  }

  @override
  void dispose() {
    _controller?.close();
  }
}
