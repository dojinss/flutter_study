import 'package:flutter/material.dart';
import 'package:sqlite_board_app/models/board.dart';
import 'package:sqlite_board_app/service/board_service.dart';

class ListScreen extends StatefulWidget {
  const ListScreen({super.key});

  @override
  State<ListScreen> createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  // state
  late Future<List<Map<String, dynamic>>> _boardList;
  final boardService = BoardService();

  @override
  void initState() {
    super.initState();
    _boardList = boardService.list();
  }

  // 삭제 확인
  Future<bool> _deleteConfirm(String id) async {
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
        title: Text("게시글 목록"),
      ),
      body: Container(
          padding: const EdgeInsets.fromLTRB(5, 0, 5, 10),
          child: FutureBuilder(
            future: _boardList,
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
                  child: Text("데이터 조회시 에러, 에러 발생"),
                );
              }
              // 데이터 없음
              else if (!snapshot.hasError && snapshot.data!.isEmpty) {
                return Center(
                  child: Text("조회된 데이터가 없습니다."),
                );
              }
              // 데이터 있음
              else {
                List<Map<String, dynamic>> boardData = snapshot.data!;
                return ListView.builder(
                  itemCount: boardData.length,
                  itemBuilder: (context, index) {
                    final board = Board.fromMap(boardData[index]);
                    String? id = board.id;
                    return GestureDetector(
                        onTap: () {
                          Navigator.pushReplacementNamed(context, '/board/read',
                              arguments: board.id);
                        },
                        child: Card(
                          child: ListTile(
                              leading: Text("${board.no}"),
                              title: Text(board.title ?? ''),
                              subtitle: Text(board.writer ?? ''),
                              trailing: PopupMenuButton(
                                onSelected: (value) {
                                  if (value == "update") {
                                    Navigator.pushReplacementNamed(
                                        context, '/board/update',
                                        arguments: id);
                                  } else if (value == "delete") {
                                    _deleteConfirm(id!);
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
                              )),
                        ));
                  },
                );
              }
            },
          )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushReplacementNamed(context, '/board/insert');
        },
        child: const Icon(Icons.create),
      ),
    );
  }
}
