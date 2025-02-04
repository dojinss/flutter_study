void main(List<String> args) {
  for (var i = 0; i < 5; i++) {
    print("숫자 : ${i + 1}");
  }

  int count = 0;
  while (count < 3) {
    print("while : ${count}");
    count++;
  }

  do {
    print("do while : ${count}");
    count--;
  } while (count > 0);

  List<int> numbers = [1, 2, 3, 4, 5, 6];
  for (var num in numbers) {
    print("for in : ${num * 2}");
  }

  numbers.forEach((item) {
    print("forEach : ${item * 2}");
  });
}
