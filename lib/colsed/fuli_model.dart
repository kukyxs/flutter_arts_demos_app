class FuliModel {
  String title;

  // ignore: non_constant_identifier_names
  String thumb_src;

  // ignore: non_constant_identifier_names
  String thumb_src_min;
  int id;

  // ignore: non_constant_identifier_names
  int img_num;

  static FuliModel fromMap(Map<String, dynamic> map) {
    FuliModel model = new FuliModel();
    model.title = map['title'];
    model.thumb_src = map['thumb_src'];
    model.thumb_src_min = map['thumb_src_min'];
    model.id = map['id'];
    model.img_num = map['img_num'];
    return model;
  }

  static List<FuliModel> fromMapList(dynamic mapList) {
    List<FuliModel> list = new List(mapList.length);
    for (int i = 0; i < mapList.length; i++) {
      list[i] = fromMap(mapList[i]);
    }
    return list;
  }
}
