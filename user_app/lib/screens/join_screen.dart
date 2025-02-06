import 'package:flutter/material.dart';

class JoinScreen extends StatefulWidget {
  const JoinScreen({super.key});

  @override
  State<JoinScreen> createState() => _JoinScreenState();
}

class _JoinScreenState extends State<JoinScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passwordCheckController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(Icons.arrow_back),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(15, 10, 15, 0),
        child: Form(
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(
                    labelText: "아이디",
                    hintText: "아이디를 입력해주세요.",
                    hintStyle: TextStyle(color: Color.fromRGBO(0, 0, 0, 0.3))),
                controller: _usernameController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "아이디를 입력해주세요.";
                  }
                },
              ),
              TextFormField(
                obscureText: true,
                decoration: InputDecoration(
                  labelText: "비밀번호",
                  hintText: "비밀번호를 입력해주세요.",
                  hintStyle: TextStyle(
                    color: Color.fromRGBO(0, 0, 0, 0.3),
                  ),
                ),
                controller: _passwordController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "비밀번호를 입력해주세요.";
                  }
                },
              ),
              TextFormField(
                obscureText: true,
                decoration: InputDecoration(
                  labelText: "비밀번호 확인",
                  hintText: "비밀번호를 입력해주세요.",
                  hintStyle: TextStyle(
                    color: Color.fromRGBO(0, 0, 0, 0.3),
                  ),
                ),
                controller: _passwordCheckController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "비밀번호를 입력해주세요.";
                  }
                  if (_passwordController.text != value) {
                    return "비밀번호가 일치하지 않습니다.";
                  }
                },
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: "이메일",
                  hintText: "이메일 주소를 입력해주세요.",
                  hintStyle: TextStyle(
                    color: Color.fromRGBO(0, 0, 0, 0.3),
                  ),
                ),
                controller: _emailController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "이메일 주소를 입력해주세요.";
                  }
                },
              ),
            ],
          ),
        ),
      ),
      bottomSheet: Container(
        height: 70,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              minimumSize: const Size(double.infinity, 70),
              backgroundColor: Colors.blueAccent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.zero,
              )),
          onPressed: () {},
          child: Text(
            "회원 가입",
            style: TextStyle(
              color: Colors.white,
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
