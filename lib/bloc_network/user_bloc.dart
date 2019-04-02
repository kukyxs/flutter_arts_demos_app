import 'package:flutter_arts_demos_app/application.dart';
import 'package:flutter_arts_demos_app/bloc/bloc_provider.dart';
import 'package:flutter_arts_demos_app/bloc_network/random_user.dart';
import 'package:rxdart/rxdart.dart';

class UserBloc extends BaseBloc {
  RandomUserModel _user;

  RandomUserModel get user => _user;

  BehaviorSubject<RandomUserModel> _controller = BehaviorSubject();

  Observable<RandomUserModel> get stream => Observable(_controller.stream);

  updateUserInfo() {
    Application.http.getRequest('https://randomuser.me/api').then((response) {
      RandomUserModel model = RandomUserModel.fromMap(response.data);
      _user = model;
      _controller.sink.add(model);
    });
  }

  @override
  void dispose() {
    _controller?.close();
  }
}
