import 'package:flutter/material.dart';
import 'package:input_widget/screens/join_screen.dart';
import 'package:input_widget/screens/login_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late TabController controller;

  @override
  void initState() {
    super.initState();
    // length : 탭의 개수
    // with SingleTickerProviderStateMixin 를 지정해서 this를 사용
    controller = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("홈화면"),
      ),
      body: TabBarView(
        controller: controller,
        children: [JoinScreen(), LoginScreen()],
      ),
      bottomNavigationBar: TabBar(
        tabs: const [
          Tab(
            child: Text("회원가입"),
          ),
          Tab(
            child: Text("로그인"),
          ),
        ],
        controller: controller,
      ),
    );
  }
}
