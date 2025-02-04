import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

// 데이터 베이스 관리 객체(싱글톤)

class DatabaseHelper {
  // 싱글톤 인스턴스
  static final DatabaseHelper instance = DatabaseHelper._init();

  // 데이터 베이스 객체
  static Database? _database;

  // 생성자
  DatabaseHelper._init();

  // 데이터베이스 객체를 반환하는 메소드
  Future<Database> get database async {
    if (_database != null) return _database!; // 이미 생성된 DB 가 있으면 그대로 반환
    _database = await _initDB('boards.db'); // DB 없으면, 새로 생성
    return _database!;
  }

  // 데이터 베이스 초기화 및 생성 함수
  Future<Database> _initDB(String fileName) async {
    final dbPath = await getDatabasesPath(); // 데이터 베이스 경로 가져오기
    final path = join(dbPath, fileName); // 데이터 베이스 경로와 파일명 조합
    // ~/sqlite_app/~/ + 파일이름

    // 데이터 베이스 열기 (경로, 버전, 처음 생성시 호출할 함수)
    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  // 데이터베이스 처음 생성 시, 초기 테이블 생성하는 함수
  Future<void> _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE boards(
        no INTEGER PRIMARY KEY AUTOINCREMENT,
        id TEXT NOT NULL,
        title TEXT NOT NULL,
        writer TEXT NOT NULL,
        content TEXT NOT NULL,
        created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
        updated_at DATETIME DEFAULT CURRENT_TIMESTAMP
      )
    ''');
  }
}
