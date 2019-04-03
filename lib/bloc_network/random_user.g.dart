// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'random_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RandomUserModel _$RandomUserModelFromJson(Map<String, dynamic> json) {
  return RandomUserModel()
    ..info = json['info'] == null
        ? null
        : InfoBean.fromJson(json['info'] as Map<String, dynamic>)
    ..results = (json['results'] as List)
        ?.map((e) =>
            e == null ? null : UserInfo.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$RandomUserModelToJson(RandomUserModel instance) =>
    <String, dynamic>{'info': instance.info, 'results': instance.results};

InfoBean _$InfoBeanFromJson(Map<String, dynamic> json) {
  return InfoBean()
    ..seed = json['seed'] as String
    ..version = json['version'] as String
    ..results = json['results'] as int
    ..page = json['page'] as int;
}

Map<String, dynamic> _$InfoBeanToJson(InfoBean instance) => <String, dynamic>{
      'seed': instance.seed,
      'version': instance.version,
      'results': instance.results,
      'page': instance.page
    };

UserInfo _$UserInfoFromJson(Map<String, dynamic> json) {
  return UserInfo()
    ..gender = json['gender'] as String
    ..email = json['email'] as String
    ..phone = json['phone'] as String
    ..cell = json['cell'] as String
    ..nat = json['nat'] as String
    ..dob = json['dob'] == null
        ? null
        : DobBean.fromJson(json['dob'] as Map<String, dynamic>)
    ..id = json['id'] == null
        ? null
        : IdBean.fromJson(json['id'] as Map<String, dynamic>)
    ..location = json['location'] == null
        ? null
        : LocationBean.fromJson(json['location'] as Map<String, dynamic>)
    ..login = json['login'] == null
        ? null
        : LoginBean.fromJson(json['login'] as Map<String, dynamic>)
    ..name = json['name'] == null
        ? null
        : NameBean.fromJson(json['name'] as Map<String, dynamic>)
    ..picture = json['picture'] == null
        ? null
        : PictureBean.fromJson(json['picture'] as Map<String, dynamic>)
    ..registered = json['registered'] == null
        ? null
        : RegisteredBean.fromJson(json['registered'] as Map<String, dynamic>);
}

Map<String, dynamic> _$UserInfoToJson(UserInfo instance) => <String, dynamic>{
      'gender': instance.gender,
      'email': instance.email,
      'phone': instance.phone,
      'cell': instance.cell,
      'nat': instance.nat,
      'dob': instance.dob,
      'id': instance.id,
      'location': instance.location,
      'login': instance.login,
      'name': instance.name,
      'picture': instance.picture,
      'registered': instance.registered
    };

DobBean _$DobBeanFromJson(Map<String, dynamic> json) {
  return DobBean()
    ..date = json['date'] as String
    ..age = json['age'] as int;
}

Map<String, dynamic> _$DobBeanToJson(DobBean instance) =>
    <String, dynamic>{'date': instance.date, 'age': instance.age};

IdBean _$IdBeanFromJson(Map<String, dynamic> json) {
  return IdBean()
    ..name = json['name'] as String
    ..value = json['value'] as String;
}

Map<String, dynamic> _$IdBeanToJson(IdBean instance) =>
    <String, dynamic>{'name': instance.name, 'value': instance.value};

LocationBean _$LocationBeanFromJson(Map<String, dynamic> json) {
  return LocationBean()
    ..street = json['street'] as String
    ..city = json['city'] as String
    ..state = json['state'] as String
    ..postcode = json['postcode'] as String
    ..coordinates = json['coordinates'] == null
        ? null
        : CoordinatesBean.fromJson(json['coordinates'] as Map<String, dynamic>)
    ..timezone = json['timezone'] == null
        ? null
        : TimezoneBean.fromJson(json['timezone'] as Map<String, dynamic>);
}

Map<String, dynamic> _$LocationBeanToJson(LocationBean instance) =>
    <String, dynamic>{
      'street': instance.street,
      'city': instance.city,
      'state': instance.state,
      'postcode': instance.postcode,
      'coordinates': instance.coordinates,
      'timezone': instance.timezone
    };

LoginBean _$LoginBeanFromJson(Map<String, dynamic> json) {
  return LoginBean()
    ..uuid = json['uuid'] as String
    ..username = json['username'] as String
    ..password = json['password'] as String
    ..salt = json['salt'] as String
    ..md5 = json['md5'] as String
    ..sha1 = json['sha1'] as String
    ..sha256 = json['sha256'] as String;
}

Map<String, dynamic> _$LoginBeanToJson(LoginBean instance) => <String, dynamic>{
      'uuid': instance.uuid,
      'username': instance.username,
      'password': instance.password,
      'salt': instance.salt,
      'md5': instance.md5,
      'sha1': instance.sha1,
      'sha256': instance.sha256
    };

NameBean _$NameBeanFromJson(Map<String, dynamic> json) {
  return NameBean()
    ..title = json['title'] as String
    ..first = json['first'] as String
    ..last = json['last'] as String;
}

Map<String, dynamic> _$NameBeanToJson(NameBean instance) => <String, dynamic>{
      'title': instance.title,
      'first': instance.first,
      'last': instance.last
    };

PictureBean _$PictureBeanFromJson(Map<String, dynamic> json) {
  return PictureBean()
    ..large = json['large'] as String
    ..medium = json['medium'] as String
    ..thumbnail = json['thumbnail'] as String;
}

Map<String, dynamic> _$PictureBeanToJson(PictureBean instance) =>
    <String, dynamic>{
      'large': instance.large,
      'medium': instance.medium,
      'thumbnail': instance.thumbnail
    };

RegisteredBean _$RegisteredBeanFromJson(Map<String, dynamic> json) {
  return RegisteredBean()
    ..date = json['date'] as String
    ..age = json['age'] as int;
}

Map<String, dynamic> _$RegisteredBeanToJson(RegisteredBean instance) =>
    <String, dynamic>{'date': instance.date, 'age': instance.age};

CoordinatesBean _$CoordinatesBeanFromJson(Map<String, dynamic> json) {
  return CoordinatesBean()
    ..latitude = json['latitude'] as String
    ..longitude = json['longitude'] as String;
}

Map<String, dynamic> _$CoordinatesBeanToJson(CoordinatesBean instance) =>
    <String, dynamic>{
      'latitude': instance.latitude,
      'longitude': instance.longitude
    };

TimezoneBean _$TimezoneBeanFromJson(Map<String, dynamic> json) {
  return TimezoneBean()
    ..offset = json['offset'] as String
    ..description = json['description'] as String;
}

Map<String, dynamic> _$TimezoneBeanToJson(TimezoneBean instance) =>
    <String, dynamic>{
      'offset': instance.offset,
      'description': instance.description
    };
