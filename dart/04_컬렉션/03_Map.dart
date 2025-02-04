void main(List<String> args) {
  // Map 리터럴 생성
  Map<String, int> map = {"김조은": 20, "김도현": 29, "원장님": 52};

  // 요소 접근 및 수정
  print("김조은의 나이 : ${map['김조은']}");
  map['김조은'] = 21;
  print("map : $map");

  // 요소 추가
  map['오승원'] = 26;
  print("map : $map");

  // 요소 제거
  map.remove("원장님");
  print("map : $map");

  map.forEach((key, value) {
    print("$key : $value");
  });
}
