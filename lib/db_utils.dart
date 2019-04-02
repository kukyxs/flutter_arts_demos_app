import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseUtils {
  final String _tableStudent = 'student';

  static Database _database; // 创建单例，防止重复打开消耗内存

  static DatabaseUtils _instance;

  static DatabaseUtils get instance => DatabaseUtils();

  DatabaseUtils._internal() {
    getDatabasesPath().then((path) async {
      _database = await openDatabase(join(path, 'demo.db'), version: 2, onCreate: (db, version) {
        // 创建数据库的时候在这边调用
        db.execute('create table $_tableStudent '
            'id integer primary key autoincrement,'
            'name text not null,'
            'weight real not null,'
            'age integer not null default 0,'
            'gender integer not null default 0');

        // 更新升级增加的字段
        db.execute('alter table $_tableStudent add column birthday text');
      }, onUpgrade: (db, oldVersion, newVersion) {
        // 更新升级数据库的时候在这操作
        if (oldVersion == 1) db.execute('alter table $_tableStudent add column birthday text');
      }, onOpen: (db) {
        // 打开数据库时候的回调
        print('${db.path}');
      });
    });
  }

  factory DatabaseUtils() {
    if (_instance == null) _instance = DatabaseUtils._internal();
    return _instance;
  }

  Future<int> insertStudent(StudentDbModel student) async => _database.insert(_tableStudent, student.toMap());

  // 批量操作需要通过 batch 实现，最后需要 commit 提交
  Future<void> insertStudents(List<StudentDbModel> students) async {
    var batch = _database.batch();
    students.forEach((s) => insertStudent(s));
    batch.commit();
  }

  // 删除操作
  Future<int> deleteStudent(int id) => _database.rawDelete('delete from $_tableStudent where id = ?', [id]);

  // 更新数据操作
  Future<int> updateStudentAge(int id, int age) =>
      _database.rawUpdate('update $_tableStudent set age = ? where id = ?', [age, id]);

  Future<int> updateStudentGender(int id, int gender) =>
      _database.rawUpdate('update $_tableStudent set gender = ? where id = ?', [gender, id]);

  // 查询
  Future<List<StudentDbModel>> queryStudents() async {
    List<StudentDbModel> students = [];
    List<Map> maps = await _database.query(_tableStudent);
    maps.forEach((map) => students.add(StudentDbModel.fromMap(map)));
    return students;
  }

  // 条件查询，会返回一个 map 列表
  Future<bool> exitsById(int id) async =>
      (await _database.rawQuery('select id, name, age, gender from $_tableStudent where id = ?', [id])).isNotEmpty;

  Future<bool> exitsByName(String name) async =>
      (await _database.rawQuery('select id, name, age, gender from $_tableStudent where name = ?', [name])).isNotEmpty;
}

class StudentDbModel {
  String name;
  int age;
  int gender;
  double weight;
  String birthday;

  StudentDbModel.empty();

  StudentDbModel(this.name, this.age, this.gender, this.weight, this.birthday);

  StudentDbModel.fromMap(Map<String, dynamic> map)
      : this.name = map['name'],
        this.age = map['age'],
        this.gender = map['gender'],
        this.weight = map['weight'],
        this.birthday = map['birthday'];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{'name': name, 'age': age, 'gender': gender, 'weight': weight, 'birthday': birthday};
  }
}
