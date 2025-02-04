import 'package:flutter/material.dart';
import 'package:sqlite_board_app/models/board.dart';
import 'package:sqlite_board_app/service/board_service.dart';

class UpdateScreen extends StatefulWidget {
  const UpdateScreen({super.key});

  @override
  State<UpdateScreen> createState() => _UpdateScreenState();
}

class _UpdateScreenState extends State<UpdateScreen> {
  // 서비스 호출
  final boardService = BoardService();
  // State
  String? id;
  late Future<Map<String, dynamic>?> _getBoard;
  late Board _updateBoard;

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _writerController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();

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
          if (id == null) {
            print("잘못된 접근입니다.");
          } else {
            _getData(id!);
          }
        }
      },
    );
  }

  Future<void> _getData(String id) async {
    final data = await boardService.select(id);
    if (data != null) {
      setState(() {
        _updateBoard = Board.fromMap(data);
        _titleController.text = _updateBoard.title ?? '';
        _writerController.text = _updateBoard.writer ?? '';
        _contentController.text = _updateBoard.content ?? '';
      });
    }
  }

  // 게시글 등록 처리
  Future<void> update(context) async {
    // 유효성 검사
    if (!_formKey.currentState!.validate()) {
      print("게시글 입력 정보가 유효하지 않습니다.");
      return;
    }

    // 게시글 객체 수정
    _updateBoard.title = _titleController.text;
    _updateBoard.writer = _writerController.text;
    _updateBoard.content = _contentController.text;

    print("_updateBoard.id : ${_updateBoard.id}");
    int result = await boardService.update(_updateBoard);
    if (result > 0) {
      print("게시글 수정 성공");
      // Navigator.pop(context);
      Navigator.pushReplacementNamed(context, "/board/read", arguments: id);
    } else {
      print("게시글 수정 실패!!");
    }
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
        title: Text("게시물 수정"),
        actions: [
          Padding(
            padding: EdgeInsets.fromLTRB(0, 0, 7, 0),
            child: PopupMenuButton(
              onSelected: (value) {
                if (value == "delete") {
                  _deleteConfirm();
                }
              },
              icon: const Icon(Icons.more_vert),
              itemBuilder: (BuildContext context) {
                return [
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
                      // _titleController.text = board.title ?? '';
                      // _writerController.text = board.writer ?? '';
                      // _contentController.text = board.content ?? '';
                      return Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              TextFormField(
                                decoration: InputDecoration(
                                    labelText: "제목",
                                    hintText: "제목을 입력해주세요.",
                                    hintStyle: TextStyle(
                                        color: Color.fromARGB(50, 50, 50, 50))),
                                controller: _titleController,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "제목을 입력하세요.";
                                  }
                                  return null;
                                },
                              ),
                              TextFormField(
                                decoration: InputDecoration(
                                    labelText: "작성자",
                                    hintText: "작성자를 입력해주세요.",
                                    hintStyle: TextStyle(
                                        color: Color.fromARGB(50, 50, 50, 50))),
                                controller: _writerController,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "작성자를 입력하세요.";
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(
                                height: 20.0,
                              ),
                              TextFormField(
                                decoration: InputDecoration(
                                    labelText: "내용",
                                    border: OutlineInputBorder(),
                                    hintText: "내용 입력해주세요.",
                                    hintStyle: TextStyle(
                                        color: Color.fromARGB(50, 50, 50, 50))),
                                controller: _contentController,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "내용 입력하세요.";
                                  }
                                  return null;
                                },
                                maxLines: 5, // 여러줄
                                keyboardType:
                                    TextInputType.multiline, // 여러줄 입력 설정
                              )
                            ],
                          ));
                    }
                  },
                )),
      bottomSheet: Container(
        height: 60,
        color: Colors.white,
        child: Center(
          child: ElevatedButton(
              onPressed: () {
                update(context);
              },
              style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50),
                  backgroundColor: Colors.blueAccent,
                  foregroundColor: Colors.white,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.zero, // 테두리 곡률 제거
                  )),
              child: const Text("수정하기")),
        ),
      ),
    );
  }
}
