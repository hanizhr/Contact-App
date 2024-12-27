import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class PersonInfo {
  int? id;
  String name;
  Map<String, String> numb;
  String email;
  bool isFavorite;
  String imageUrl;

  PersonInfo({
    this.id,
    required this.email,
    required this.numb,
    required this.name,
    required this.isFavorite,
    required this.imageUrl,
  });

  Map<String, Object?> toMap() {
    return {
      'id': id,
      'name': name,
      'phone': numb['phone'],
      'home': numb['home'],
      'email': email,
      'isFavorite': isFavorite ? 1 : 0,
      'imageUrl': imageUrl,
    };
  }
}

class DatabaseService {
  static Database? _db;
  static final DatabaseService instace = DatabaseService._constractor();
  final String _contactsTableName = 'contacts';
  final String _contactsIdColumnName = 'id';
  final String _contactsNameColumnName = 'name';
  final String _contactsPhoneColumnName = 'phone';
  final String _contactsHomeColumnName = 'home';
  final String _contactsEmailColumnName = 'email';
  final String _contactsIsFavoriteColumnName = 'isFavorite';
  final String _contactsImageUrlColumnName = 'imageUrl';

  DatabaseService._constractor();

  Future<Database> get database async {
    if (_db != null) return _db!;
    _db = await getDatabase();
    return _db!;
  }

  Future<Database> getDatabase() async {
    final databaseDirPath = await getDatabasesPath();
    final DatabasePath = join(databaseDirPath, 'contacts_db.db');

    final database = await openDatabase(
      DatabasePath,
      onCreate: (db, version) {
        return db.execute(
          '''CREATE TABLE $_contactsTableName(
          $_contactsIdColumnName INTEGER PRIMARY KEY AUTOINCREMENT,
          $_contactsNameColumnName TEXT,
          $_contactsPhoneColumnName TEXT,
          $_contactsHomeColumnName TEXT,
          $_contactsEmailColumnName TEXT,
          $_contactsIsFavoriteColumnName INTEGER DEFAULT 0,
          $_contactsImageUrlColumnName TEXT)
          ''',
        );
      },
      version: 1,
    );
    return database;
  }

  Future<void> insertPerson(PersonInfo person) async {
    final db = await database;
    await db.insert(
      _contactsTableName,
      person.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<PersonInfo>> contacts() async {
    final db = await database;

    final contactMaps = await db.query(_contactsTableName);
    return [
      for (final map in contactMaps)
        PersonInfo(
          id: map[_contactsIdColumnName] as int,
          email: map[_contactsEmailColumnName] as String,
          numb: {
            'phone': map[_contactsPhoneColumnName]?.toString() ?? '',
            'home': map[_contactsHomeColumnName]?.toString() ?? '',
          },
          name: map[_contactsNameColumnName] as String,
          isFavorite: (map[_contactsIsFavoriteColumnName] as int) == 1,
          imageUrl: map[_contactsImageUrlColumnName] as String,
        ),
    ];
  }

  Future<void> deleteContact(int id) async {
    final db = await database;
    await db.delete(
      _contactsTableName,
      where: '$_contactsIdColumnName = ?',
      whereArgs: [id],
    );
  }

  Future<void> updateContact(PersonInfo person) async {
    final db = await database;
    await db.update(
      _contactsTableName,
      person.toMap(),
      where: '$_contactsIdColumnName = ?',
      whereArgs: [person.id],
    );
  }
}
