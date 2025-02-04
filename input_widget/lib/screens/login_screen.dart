import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // State
  bool _rememberId = false; // 아이디 저장
  bool _rememberMe = false; // 자동 로그인

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(30.0),
      child: ListView(
        children: [
          const Text(
            "로그인",
            style: TextStyle(fontSize: 30.0),
          ),
          Column(
            children: [
              SizedBox(
                height: 20.0,
              ),
              TextField(
                autofocus: true,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "아이디",
                    hintText: "아이디를 입력해주세요."),
              ),
              SizedBox(
                height: 20.0,
              ),
              TextField(
                obscureText: true,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "비밀번호",
                    hintText: "비밀번호를 입력해주세요."),
              ),
              SizedBox(
                height: 20.0,
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    Row(
                      children: [
                        Checkbox(
                          value: _rememberId,
                          onChanged: (value) {
                            print("아이디 저장 여부 : ${value}");
                            setState(() {
                              _rememberId = !_rememberId;
                            });
                          },
                        ),
                        GestureDetector(
                            onTap: () {
                              setState(() {
                                _rememberId = !_rememberId;
                              });
                            },
                            child: const Text("아이디 저장"))
                      ],
                    ),
                    Row(
                      children: [
                        Checkbox(
                          value: _rememberMe,
                          onChanged: (value) {
                            print("자동 로그인 여부 :  ${value}");
                            setState(() {
                              _rememberMe = !_rememberMe;
                            });
                          },
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _rememberMe = !_rememberMe;
                            });
                          },
                          child: const Text("자동 로그인"),
                        )
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0) // 테두리
                          ),
                      // 버튼의 최소 크기 - 가로 , 세로
                      // double.infinity : 디바이스의 최대크기로 지정
                      minimumSize: const Size(double.infinity, 50.0)),
                  child: const Text(
                    "로그인",
                    style: TextStyle(fontSize: 24),
                  ))
            ],
          )
        ],
      ),
    );
  }
}
