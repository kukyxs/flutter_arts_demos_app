import 'package:json_annotation/json_annotation.dart';

part 'random_user.g.dart';

@JsonSerializable()
class RandomUserModel {
  InfoBean info;
  List<UserInfo> results;

  RandomUserModel();

  factory RandomUserModel.fromJson(json) => _$RandomUserModelFromJson(json);

  static Map<String, dynamic> toJson(RandomUserModel model) => _$RandomUserModelToJson(model);

  static RandomUserModel fromMap(Map<String, dynamic> map) {
    RandomUserModel user = new RandomUserModel();
    user.info = InfoBean.fromMap(map['info']);
    user.results = UserInfo.fromMapList(map['results']);
    return user;
  }

  static List<RandomUserModel> fromMapList(dynamic mapList) {
    List<RandomUserModel> list = new List(mapList.length);
    for (int i = 0; i < mapList.length; i++) {
      list[i] = fromMap(mapList[i]);
    }
    return list;
  }
}

@JsonSerializable()
class InfoBean {
  String seed;
  String version;
  int results;
  int page;

  InfoBean();

  factory InfoBean.fromJson(json) => _$InfoBeanFromJson(json);

  static toJson(InfoBean info) => _$InfoBeanToJson(info);

  static InfoBean fromMap(Map<String, dynamic> map) {
    InfoBean infoBean = new InfoBean();
    infoBean.seed = map['seed'];
    infoBean.version = map['version'];
    infoBean.results = map['results'];
    infoBean.page = map['page'];
    return infoBean;
  }

  static List<InfoBean> fromMapList(dynamic mapList) {
    List<InfoBean> list = new List(mapList.length);
    for (int i = 0; i < mapList.length; i++) {
      list[i] = fromMap(mapList[i]);
    }
    return list;
  }
}

@JsonSerializable()
class UserInfo {
  String gender;
  String email;
  String phone;
  String cell;
  String nat;
  DobBean dob;
  IdBean id;
  LocationBean location;
  LoginBean login;
  NameBean name;
  PictureBean picture;
  RegisteredBean registered;

  UserInfo();

  factory UserInfo.fromJson(json) => _$UserInfoFromJson(json);

  static toJson(UserInfo user) => _$UserInfoToJson(user);

  static UserInfo fromMap(Map<String, dynamic> map) {
    UserInfo resultsListBean = new UserInfo();
    resultsListBean.gender = map['gender'];
    resultsListBean.email = map['email'];
    resultsListBean.phone = map['phone'];
    resultsListBean.cell = map['cell'];
    resultsListBean.nat = map['nat'];
    resultsListBean.dob = DobBean.fromMap(map['dob']);
    resultsListBean.id = IdBean.fromMap(map['id']);
    resultsListBean.location = LocationBean.fromMap(map['location']);
    resultsListBean.login = LoginBean.fromMap(map['login']);
    resultsListBean.name = NameBean.fromMap(map['name']);
    resultsListBean.picture = PictureBean.fromMap(map['picture']);
    resultsListBean.registered = RegisteredBean.fromMap(map['registered']);
    return resultsListBean;
  }

  static List<UserInfo> fromMapList(dynamic mapList) {
    List<UserInfo> list = new List(mapList.length);
    for (int i = 0; i < mapList.length; i++) {
      list[i] = fromMap(mapList[i]);
    }
    return list;
  }
}

@JsonSerializable()
class DobBean {
  String date;
  int age;

  DobBean();

  factory DobBean.fromJson(json) => _$DobBeanFromJson(json);

  static toJson(DobBean dob) => _$DobBeanToJson(dob);

  static DobBean fromMap(Map<String, dynamic> map) {
    DobBean dobBean = new DobBean();
    dobBean.date = map['date'];
    dobBean.age = map['age'];
    return dobBean;
  }

  static List<DobBean> fromMapList(dynamic mapList) {
    List<DobBean> list = new List(mapList.length);
    for (int i = 0; i < mapList.length; i++) {
      list[i] = fromMap(mapList[i]);
    }
    return list;
  }
}

@JsonSerializable()
class IdBean {
  String name;
  String value;

  IdBean();

  factory IdBean.fromJson(json) => _$IdBeanFromJson(json);

  static toJson(IdBean id) => _$IdBeanToJson(id);

  static IdBean fromMap(Map<String, dynamic> map) {
    IdBean idBean = new IdBean();
    idBean.name = map['name'];
    idBean.value = map['value'];
    return idBean;
  }

  static List<IdBean> fromMapList(dynamic mapList) {
    List<IdBean> list = new List(mapList.length);
    for (int i = 0; i < mapList.length; i++) {
      list[i] = fromMap(mapList[i]);
    }
    return list;
  }
}

@JsonSerializable()
class LocationBean {
  String street;
  String city;
  String state;
  String postcode;
  CoordinatesBean coordinates;
  TimezoneBean timezone;

  LocationBean();

  factory LocationBean.fromJson(json) => _$LocationBeanFromJson(json);

  static toJson(LocationBean location) => _$LocationBeanToJson(location);

  static LocationBean fromMap(Map<String, dynamic> map) {
    LocationBean locationBean = new LocationBean();
    locationBean.street = map['street'];
    locationBean.city = map['city'];
    locationBean.state = map['state'];
    locationBean.postcode = '${map['postcode']}';
    locationBean.coordinates = CoordinatesBean.fromMap(map['coordinates']);
    locationBean.timezone = TimezoneBean.fromMap(map['timezone']);
    return locationBean;
  }

  static List<LocationBean> fromMapList(dynamic mapList) {
    List<LocationBean> list = new List(mapList.length);
    for (int i = 0; i < mapList.length; i++) {
      list[i] = fromMap(mapList[i]);
    }
    return list;
  }
}

@JsonSerializable()
class LoginBean {
  String uuid;
  String username;
  String password;
  String salt;
  String md5;
  String sha1;
  String sha256;

  LoginBean();

  factory LoginBean.fromJson(json) => _$LoginBeanFromJson(json);

  static toJson(LoginBean login) => _$LoginBeanToJson(login);

  static LoginBean fromMap(Map<String, dynamic> map) {
    LoginBean loginBean = new LoginBean();
    loginBean.uuid = map['uuid'];
    loginBean.username = map['username'];
    loginBean.password = map['password'];
    loginBean.salt = map['salt'];
    loginBean.md5 = map['md5'];
    loginBean.sha1 = map['sha1'];
    loginBean.sha256 = map['sha256'];
    return loginBean;
  }

  static List<LoginBean> fromMapList(dynamic mapList) {
    List<LoginBean> list = new List(mapList.length);
    for (int i = 0; i < mapList.length; i++) {
      list[i] = fromMap(mapList[i]);
    }
    return list;
  }
}

@JsonSerializable()
class NameBean {
  String title;
  String first;
  String last;

  NameBean();

  factory NameBean.fromJson(json) => _$NameBeanFromJson(json);

  static toJson(NameBean name) => _$NameBeanToJson(name);

  static NameBean fromMap(Map<String, dynamic> map) {
    NameBean nameBean = new NameBean();
    nameBean.title = map['title'];
    nameBean.first = map['first'];
    nameBean.last = map['last'];
    return nameBean;
  }

  static List<NameBean> fromMapList(dynamic mapList) {
    List<NameBean> list = new List(mapList.length);
    for (int i = 0; i < mapList.length; i++) {
      list[i] = fromMap(mapList[i]);
    }
    return list;
  }
}

@JsonSerializable()
class PictureBean {
  String large;
  String medium;
  String thumbnail;

  PictureBean();

  factory PictureBean.fromJson(json) => _$PictureBeanFromJson(json);

  static toJson(PictureBean pic) => _$PictureBeanToJson(pic);

  static PictureBean fromMap(Map<String, dynamic> map) {
    PictureBean pictureBean = new PictureBean();
    pictureBean.large = map['large'];
    pictureBean.medium = map['medium'];
    pictureBean.thumbnail = map['thumbnail'];
    return pictureBean;
  }

  static List<PictureBean> fromMapList(dynamic mapList) {
    List<PictureBean> list = new List(mapList.length);
    for (int i = 0; i < mapList.length; i++) {
      list[i] = fromMap(mapList[i]);
    }
    return list;
  }
}

@JsonSerializable()
class RegisteredBean {
  String date;
  int age;

  RegisteredBean();

  factory RegisteredBean.fromJson(json) => _$RegisteredBeanFromJson(json);

  static toJson(RegisteredBean register) => _$RegisteredBeanToJson(register);

  static RegisteredBean fromMap(Map<String, dynamic> map) {
    RegisteredBean registeredBean = new RegisteredBean();
    registeredBean.date = map['date'];
    registeredBean.age = map['age'];
    return registeredBean;
  }

  static List<RegisteredBean> fromMapList(dynamic mapList) {
    List<RegisteredBean> list = new List(mapList.length);
    for (int i = 0; i < mapList.length; i++) {
      list[i] = fromMap(mapList[i]);
    }
    return list;
  }
}

@JsonSerializable()
class CoordinatesBean {
  String latitude;
  String longitude;

  CoordinatesBean();

  factory CoordinatesBean.fromJson(json) => _$CoordinatesBeanFromJson(json);

  static toJson(CoordinatesBean coordinates) => _$CoordinatesBeanToJson(coordinates);

  static CoordinatesBean fromMap(Map<String, dynamic> map) {
    CoordinatesBean coordinatesBean = new CoordinatesBean();
    coordinatesBean.latitude = map['latitude'];
    coordinatesBean.longitude = map['longitude'];
    return coordinatesBean;
  }

  static List<CoordinatesBean> fromMapList(dynamic mapList) {
    List<CoordinatesBean> list = new List(mapList.length);
    for (int i = 0; i < mapList.length; i++) {
      list[i] = fromMap(mapList[i]);
    }
    return list;
  }
}

@JsonSerializable()
class TimezoneBean {
  String offset;
  String description;

  TimezoneBean();

  factory TimezoneBean.fromJson(json) => _$TimezoneBeanFromJson(json);

  static toJson(TimezoneBean tz) => _$TimezoneBeanToJson(tz);

  static TimezoneBean fromMap(Map<String, dynamic> map) {
    TimezoneBean timezoneBean = new TimezoneBean();
    timezoneBean.offset = map['offset'];
    timezoneBean.description = map['description'];
    return timezoneBean;
  }

  static List<TimezoneBean> fromMapList(dynamic mapList) {
    List<TimezoneBean> list = new List(mapList.length);
    for (int i = 0; i < mapList.length; i++) {
      list[i] = fromMap(mapList[i]);
    }
    return list;
  }
}
