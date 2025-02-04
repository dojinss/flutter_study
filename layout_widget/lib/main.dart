import 'package:flutter/material.dart';
import 'package:layout_widget/screens/gridview_screen.dart';
void main() {
  runApp(const MyApp());
}
class MyApp extends StatefulWidget {
  const MyApp({super.key});
  
  @override
  State<StatefulWidget> createState() => _MyAppState();
}
class _MyAppState extends State {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "레이아웃 위젯",
      home: GridviewScreen()
    );
  }
}