import 'package:flutter/material.dart';
import 'package:sqlite_board_app/models/board.dart';
import 'package:sqlite_board_app/service/board_service.dart';

class ReadScreen extends StatefulWidget {
  const ReadScreen({super.key});

  @override
  State<ReadScreen> createState() => _ReadScreenState();
}

class _ReadScreenState extends State<ReadScreen> {
  // 서비스 호출
  final boardService = BoardService();
  // State
  String? id;
  late Future<Map<String, dynamic>?> _getBoard;
  // late Board _board;

  @override
  void initState() {
    super.initState();
    // 넘겨받은 값 설정
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        final args = ModalRoute.of(context)!.settings.arguments;
        if (args is String) {
          setState(() {
            id = args;
            print("id : $id");
            // 게시물 정보 조회 요청
            _getBoard = boardService.select(id ?? '');
          });
        }
      },
    );
  }

  // 삭제 확인
  Future<bool> _deleteConfirm() async {
    bool result = false;
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("삭제 확인"),
          content: Text("해당 게시글을 삭제 하시겠습니까?"),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop(true);
                },
                child: Text("삭제")),
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
                child: Text("취소")),
          ],
        );
      },
    ).then(
      (value) {
        // [삭제],[취소] 클릭 후
        result = value ?? false;
        if (result) {
          delete(id!);
        }
      },
    );
    return result;
  }

  // 게시글 삭제
  Future<void> delete(String id) async {
    int result = await boardService.delete(id);
    if (result > 0) {
      Navigator.pushReplacementNamed(context, '/board/list');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.pushReplacementNamed(context, '/board/list');
          },
          child: Icon(Icons.arrow_back),
        ),
        title: Text("게시글 조회"),
        actions: [
          Padding(
            padding: EdgeInsets.fromLTRB(0, 0, 7, 0),
            child: PopupMenuButton(
              onSelected: (value) {
                if (value == "update") {
                  Navigator.pushReplacementNamed(context, '/board/update',
                      arguments: id);
                } else if (value == "delete") {
                  _deleteConfirm();
                }
              },
              icon: const Icon(Icons.more_vert),
              itemBuilder: (BuildContext context) {
                return [
                  const PopupMenuItem(
                      value: "update",
                      child: Row(
                        children: [
                          Icon(
                            Icons.edit,
                            color: Colors.black,
                          ),
                          SizedBox(
                            width: 8.0,
                          ),
                          Text("수정하기")
                        ],
                      )),
                  const PopupMenuItem(
                      value: "delete",
                      child: Row(
                        children: [
                          Icon(
                            Icons.delete,
                            color: Colors.black,
                          ),
                          SizedBox(
                            width: 8.0,
                          ),
                          Text("삭제하기")
                        ],
                      )),
                ];
              },
            ),
          ),
        ],
      ),
      body: Padding(
          padding: EdgeInsets.fromLTRB(5, 0, 5, 10),
          child: id == null
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : FutureBuilder(
                  future: _getBoard,
                  builder: (context, snapshot) {
                    // 로딩중
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }

                    // 에러
                    else if (snapshot.hasError) {
                      return Center(
                        child: Text("데이터 조회 중, 에러 발생"),
                      );
                    }

                    // 데이터 없음
                    else if (snapshot.hasError || snapshot.data!.isEmpty) {
                      return Center(
                        child: Text("조회된 데이터가 없습니다."),
                      );
                    }

                    // 데이터 있음
                    else {
                      Board board = Board.fromMap(snapshot.data!);
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Card(
                            child: ListTile(
                              leading: const Icon(Icons.article),
                              title: Text(board.title ?? '제목 없음'),
                            ),
                          ),
                          Card(
                            child: ListTile(
                              leading: const Icon(Icons.person),
                              title: Text(board.writer ?? '작성자 없음'),
                            ),
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 4.0),
                            padding: const EdgeInsets.all(12.0),
                            width: double.infinity,
                            height: 320,
                            decoration: BoxDecoration(
                              color: Theme.of(context).scaffoldBackgroundColor,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withValues(alpha: 0.3),
                                  spreadRadius: 2,
                                  blurRadius: 8,
                                  offset: const Offset(4, 4),
                                ),
                              ],
                              borderRadius: BorderRadius.circular(0),
                            ),
                            child: SingleChildScrollView(
                              child: Text(board.content ?? "내용 없음."),
                            ),
                          )
                        ],
                      );
                    }
                  },
                )),
    );
  }
}
