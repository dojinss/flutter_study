import 'package:flutter/material.dart';
import 'package:sqlite_board_app/screens/board/insert_screen.dart';
import 'package:sqlite_board_app/screens/board/list_screen.dart';
import 'package:sqlite_board_app/screens/board/read_screen.dart';
import 'package:sqlite_board_app/screens/board/update_screen.dart';
import 'package:sqlite_board_app/screens/main_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'HTTP - 게시판 앱',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: '/main',
      routes: {
        '/main': (context) => const MainScreen(),
        '/board/list': (context) => const ListScreen(),
        '/board/read': (context) => const ReadScreen(),
        '/board/insert': (context) => const InsertScreen(),
        '/board/update': (context) => const UpdateScreen(),
      },
    );
  }
}
