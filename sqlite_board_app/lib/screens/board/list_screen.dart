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
                              trailing: Icon(Icons.more_vert)),
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
