// 익명 함수
// - 변수에 할당
// - 매개변수로 전달
// 🎈Dart 의 함수 타입 : function

void test(String msg, Function callback) {
  print("메세지 : $msg");
  callback(100);
}

void main(List<String> args) {
  // 익명 함수
  var callback = (int data) {
    print("콜백 함수 - data : $data");
  };

  test("안녕하세요.", callback);

  test("반갑습니다", (int data) {
    print("콜백2 - data : $data");
  });
}
