import 'package:calendar_date_picker2/calendar_date_picker2.dart' as picker;
import 'package:flutter/material.dart';

class JoinScreen extends StatefulWidget {
  const JoinScreen({super.key});

  @override
  State<JoinScreen> createState() => _JoinScreenState();
}

class _JoinScreenState extends State<JoinScreen> {
  // State
  // _ (언더바) 가 붙는경우 변수는 private 변수가된다
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _pwController = TextEditingController();
  final TextEditingController _pwCheckController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _birthController = TextEditingController();

  // 성별
  String _gender = "남자";

  // 날짜
  final List<DateTime> _dates = [DateTime.now()];

  // 달력 설정
  final dateConfig = picker.CalendarDatePicker2Config(
    // 셀럭터 타입
    calendarType: picker.CalendarDatePicker2Type.range,
    // 선택된 날짜 색상
    selectedDayHighlightColor: Colors.redAccent,
    // 요일 라벨
    weekdayLabels: ["일", "월", "화", "수", "목", "금", "토"],
    // 요일 스타일
    weekdayLabelTextStyle:
        const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
    // 시작 요일 : 0 (일) , 1 (월)
    firstDayOfWeek: 0,
    // 컨트롤 높이 사이즈
    controlsHeight: 100,
    // 날짜 스타일
    dayTextStyle: const TextStyle(color: Colors.green),
    // 비활성화된 날짜 스타일
    disabledDayTextStyle: const TextStyle(color: Colors.grey),
    // 선택가능한 날짜 설정
    // DateTime.now() : 현재
    // difference() : 두 날짜 간의 차이
    // subtract() : 해당 숫자만큼 날짜를 뺌
    // isNegative : 음수인지 확인 (특정 날짜와 어제 날짜 사이의 차이가 음수면 true)
    selectableDayPredicate: (day) => !day
        .difference(DateTime.now().subtract(const Duration(days: 1)))
        .isNegative,
  );

  // 폼 키
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.0),
      child: ListView(children: [
        const Text(
          "회원가입",
          style: TextStyle(fontSize: 30.0),
        ),
        Form(
          key: _formKey,
          child: Column(
            children: [
              // 아이디
              TextFormField(
                autofocus: true, // 자동 커서 지정
                decoration: const InputDecoration(
                    labelText: "아이디",
                    hintText: "아이디를 입력해주세요",
                    hintStyle:
                        TextStyle(color: Color.fromARGB(50, 50, 50, 50))),
                controller: _idController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "아이디를 입력해주세요";
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 15.0,
              ),
              TextFormField(
                obscureText: true,
                decoration: const InputDecoration(
                    labelText: "비밀번호",
                    hintText: "비밀번호를 입력해주세요",
                    hintStyle:
                        TextStyle(color: Color.fromARGB(50, 50, 50, 50))),
                controller: _pwController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "비밀번호를 입력해주세요";
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 15.0,
              ),
              TextFormField(
                obscureText: true,
                decoration: const InputDecoration(
                    labelText: "비밀번호확인",
                    hintText: "비밀번호확인를 입력해주세요",
                    hintStyle:
                        TextStyle(color: Color.fromARGB(50, 50, 50, 50))),
                controller: _pwCheckController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "비밀번호확인를 입력해주세요";
                  }
                  if (value != _pwController.text) {
                    return "비밀번호가 일치하지 않습니다.";
                  }
                  return null;
                },
              ),

              SizedBox(
                height: 15.0,
              ),

              Row(
                children: [
                  Text("성별"),
                  Radio(
                      value: "남자",
                      groupValue: _gender,
                      onChanged: (value) {
                        setState(() {
                          _gender = "남자";
                        });
                      }),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _gender = "남자";
                      });
                    },
                    child: Text("남자"),
                  ),
                  Radio(
                      value: "여자",
                      groupValue: _gender,
                      onChanged: (value) {
                        setState(() {
                          _gender = "여자";
                        });
                      }),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _gender = "여자";
                      });
                    },
                    child: Text("여자"),
                  ),
                ],
              ),
              SizedBox(
                height: 15.0,
              ),

              Column(
                children: [
                  TextFormField(
                    controller: _birthController,
                    readOnly: true,
                    decoration: InputDecoration(
                        labelText: "생년월일",
                        hintText: "달력을 눌러주세요.",
                        hintStyle:
                            TextStyle(color: Color.fromARGB(100, 50, 50, 50)),
                        suffixIcon: GestureDetector(
                          onTap: () async {
                            // ignore: avoid_print
                            print("생년월일 달력 아이콘 클릭...");

                            final result = await showDialog<List<DateTime>>(
                                context: context,
                                builder: (context) {
                                  return Dialog(
                                    child: picker.CalendarDatePicker2(
                                      config: picker.CalendarDatePicker2Config(
                                          calendarType: picker
                                              .CalendarDatePicker2Type.single,
                                          selectedDayHighlightColor:
                                              Colors.orange,
                                          weekdayLabels: [
                                            "일",
                                            "월",
                                            "화",
                                            "수",
                                            "목",
                                            "금",
                                            "토"
                                          ]),
                                      value: _dates,
                                      onValueChanged: (dates) {
                                        print(dates[0]);
                                        if (dates.isNotEmpty) {
                                          Navigator.pop(context, dates);
                                          // _dates[0] = dates[0];
                                        }
                                      },
                                    ),
                                  );
                                });

                            if (result != null && result.isNotEmpty) {
                              final formatDate = "${result[0].year}"
                                  "/${result[0].month.toString().padLeft(2, "0")}"
                                  "/${result[0].day.toString().padLeft(2, "0")}";
                              _birthController.text = formatDate;
                            }
                          },
                          child: Icon(Icons.calendar_month),
                        )),
                  )
                ],
              ),
              SizedBox(
                height: 15.0,
              ),

              picker.CalendarDatePicker2(
                  config: dateConfig,
                  value: [],
                  onValueChanged: (dates) {
                    print(dates);
                    if (dates.length == 2) {
                      print("시작일 : ${dates[0]}");
                      print("종료일 : ${dates[1]}");
                    }
                  }),

              SizedBox(
                height: 30.0,
              ),
              ElevatedButton(
                  onPressed: () {
                    // 유효성검사
                    if (_formKey.currentState!.validate()) {
                      // 유효성 검사 성공
                      print("유효성 검사 성공!");

                      print("아이디 : ${_idController.text}");
                      print("비밀번호 : ${_pwController.text}");
                      print("비밀번호 확인 : ${_pwCheckController.text}");
                      print("성별 : ${_gender}");
                      print("생년월일 : ${_birthController.text}");
                      print("선택날짜 : ${_dates}");
                    } else {
                      // 유효성 검사 실패
                      print("유효성 검사 실패");
                    }
                  },
                  child: Text("회원가입")),
            ],
          ),
        )
      ]),
    );
  }
}
