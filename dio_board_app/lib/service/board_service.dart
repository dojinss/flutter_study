import "package:dio/dio.dart";
import "package:sqlite_board_app/models/board.dart";

class BoardService {
  // 테이블 이름
  final String URL = 'http://10.0.2.2:8080/boards';
  final Dio dio = Dio();

  // 데이터 목록 조회
  Future<List<Map<String, dynamic>>> list() async {
    var list;
    try {
      Response response = await dio.get(URL);
      print(":::::reponse - body ::::::");
      print(response.data);
      var data = response.data;
      // // "list" 키가 존재하고 리스트 타입인지 확인 후 추출
      if (data.containsKey("list") && data["list"] is List) {
        list = (data["list"] as List).map((e) => e as Map<String, dynamic>).toList();
      }
    } catch (e) {
      print(e);
    }
    return list;
  }

  // 데이터 단일 조회
  Future<Map<String, dynamic>?> select(String id) async {
    var board;
    try {
      var response = await dio.get(URL + '/$id');
      print(":::::reponse - body ::::::");
      var data = response.data;
      if (data.containsKey("board") && data["board"] is Map<String, dynamic>) {
        board = data["board"] as Map<String, dynamic>;
      }
      print(board);
    } catch (e) {
      print(e);
    }
    return board;
  }

  // 데이터 등록
  Future<int> insert(Board board) async {
    int result = 0;
    try {
      var response = await dio.post(URL, data: board.toMap());

      print(":::::reponse - body ::::::");
      print(response.data);

      if (response.statusCode == 200 || response.statusCode == 201) {
        result = 1;
        print("게시글 등록 성공");
      } else {
        print("게시글 등록 실패!");
      }
    } catch (e) {
      print(e);
    }
    return result;
  }

  // 데이터 수정
  Future<int> update(Board board) async {
    int result = 0;
    try {
      var response = await dio.put(URL, data: board.toMap());
      print(":::::reponse - body ::::::");
      print(response.data);

      if (response.statusCode == 200 || response.statusCode == 201) {
        result = 1;
        print("게시글 수정 성공");
      } else {
        print("게시글 수정 실패!");
      }
    } catch (e) {
      print(e);
    }
    return result;
  }

  // 데이터 삭제
  Future<int> delete(String id) async {
    int result = 0;
    try {
      var response = await dio.delete(URL + "/$id");
      print(":::::reponse - body ::::::");
      print(response.data);

      if (response.statusCode == 200 || response.statusCode == 201) {
        result = 1;
        print("게시글 삭제 성공");
      } else {
        print("게시글 삭제 실패!");
      }
    } catch (e) {
      print(e);
    }
    return result;
  }
}
