void main(List<String> args) {
  Set<String> sets = {"빅맥", "포테이토", "콜라"};
  print("sets : ${sets}");

  // 요소 추가
  sets.add("치즈스틱");
  print("sets : ${sets}");

  // 요소 제거
  sets.remove("포테이토");
  print("sets : ${sets}");

  // 중복 요소 추가해보기
  var result = sets.add("콜라");
  print("중복 여부 : ${!result}");
  print("sets : ${sets}");

  // Set 반복
  sets.forEach((item) {
    print(item);
  });

  // 첫번째 요소, 마지막 요소
  print("첫번째 : ${sets.first}");
  print("첫번째 : ${sets.last}");

  // 전체 삭제
  sets.clear();
  print("sets : ${sets}");

  // 비어 있는지 확인
  if (sets.isEmpty) {
    print("세트가 비었습니다.");
  }

  // Set 객체 생성
  Set<String> test = Set();
  test.add("아이템 1");
  test.add("아이템 2");
  test.add("아이템 3");
  print("test : ${test}");

  //
  Set<int> data = {};
  data.add(1);
  data.add(2);
  data.add(3);
  data.add(4);
  data.add(5);
  print("data : ${data}");
}
