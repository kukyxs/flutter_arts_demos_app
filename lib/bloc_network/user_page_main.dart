import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_arts_demos_app/bloc/bloc_provider.dart';
import 'package:flutter_arts_demos_app/bloc_network/random_user.dart';
import 'package:flutter_arts_demos_app/bloc_network/user_bloc.dart';

class UserPageDemo extends StatelessWidget {
  String _upperFirst(String content) {
    assert(content != null && content.isNotEmpty);
    return '${content.substring(0, 1).toUpperCase()}${content.substring(1)}';
  }

  Widget _userLocation(String info) => Padding(
      padding: const EdgeInsets.only(top: 4.0),
      child: Text(info, style: TextStyle(color: Colors.white, fontSize: 16.0)));

  @override
  Widget build(BuildContext context) {
    UserBloc _bloc = BlocProvider.of<UserBloc>(context);
    _bloc.updateUserInfo();

    return Scaffold(
      body: StreamBuilder(
          builder: (_, AsyncSnapshot<RandomUserModel> snapshot) => Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Colors.blue[600], Colors.blue[400]])),
                child: !snapshot.hasData
                    ? CupertinoActivityIndicator(radius: 12.0)
                    : Column(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
                        InkWell(
                            child: ClipOval(
                              child: FadeInImage.assetNetwork(
                                  placeholder: 'images/ava_default.png', image: snapshot.data.results[0].picture.large),
                            ),
                            onTap: () => _bloc.updateUserInfo()),
                        Padding(
                          padding: const EdgeInsets.only(top: 20.0),
                          child: Text(
                              '${_upperFirst(snapshot.data.results[0].name.first)} ${_upperFirst(snapshot.data.results[0].name.last)}',
                              style: TextStyle(color: Colors.white, fontSize: 24.0)),
                        ),
                        Text('${snapshot.data.results[0].email}',
                            style: TextStyle(color: Colors.white, fontSize: 18.0)),
                        _userLocation('${snapshot.data.results[0].location.street}'),
                        _userLocation('${_upperFirst(snapshot.data.results[0].location.city)}'),
                        _userLocation('${_upperFirst(snapshot.data.results[0].location.state)}'),
                      ]),
              ),
          initialData: _bloc.user,
          stream: _bloc.stream),
    );
  }
}
