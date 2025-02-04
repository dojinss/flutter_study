void main(List<String> args) {
  int number = 100;
  if (number > 0) {
    print("양수 입니다.");
  } else if (number < 0) {
    print("음수 입니다.");
  } else {
    print("0 입니다.");
  }

  String grade = "B";
  switch (grade) {
    case "A":
      print("A 학점");
    case "B":
      print("B 학점");
    case "C":
      print("C 학점");
    case "D":
      print("D 학점");
    case "E":
      print("E 학점");
    default:
      print("예외");
  }
}
