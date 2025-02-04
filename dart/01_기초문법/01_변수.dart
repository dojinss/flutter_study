void main(List<String> args) {
  int age = 25;
  String name = "이름";

  print("이름 : $name");
  print("나이 : $age");

  // 실수
  double weight = 45.56;
  double height = 170.23;
  print("weight : $weight");
  print("height : $height");

  // 불리언
  bool check = true;
  if (check) {
    print("check : $check");
  }

  // 널 허용
  int? data = null;
  print("data : $data");

  data = 10;
  print("data (Not Null) : ${data!}");
  int? data2 = data;
  print("data2 (Not Null) : ${data2!}");

  const PI = 3.141592;
  final String systemCode;
  systemCode = "SYS0001";

  print("PI : $PI");
  print("systemCode : $systemCode");
}
