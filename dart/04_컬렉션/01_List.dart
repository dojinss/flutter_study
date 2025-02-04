void main(List<String> args) {
  List<int> list = [1, 2, 3, 4, 5];
  print("list : ${list}");

  // 리스트 요소 접근 및 수정
  list[0] = 100;
  print("list[0] : ${list[0]}");

  // 리스트 길이
  print("리스트 길이 : ${list.length}");

  // 리스트 요소 추가
  list.add(55);
  print("list : $list");

  // 리스트 요소 제거(remove) - 값으로 제거
  list.remove(55);
  print("list : $list");

  // 리스트 요소 제거(removeAt) - index로 제거
  list.removeAt(3); // index : 3인 요소 제거
  print("list : $list");

  // 리스트 반복
  list.forEach((item) {
    print(item);
  });

  // 첫번째 요소, 마지막 요소
  print("첫번째 : ${list.first}");
  print("첫번째 : ${list.last}");

  List<String> wordList = ["A", "B", "C", "D", "E"];
  print("wordList : ${wordList}");

  // 역방향 정렬
  print("wordList : ${wordList.reversed}");
  List<String> reversedWordList = wordList.reversed.toList();
  print("reversedWordList : ${reversedWordList}");

  // 정방향 정렬
  List<int> numList = [9, 5, 7, 1, 2, 45];
  numList.sort();
  print("이번 주 로또 당첨번호 입니다 : ${numList}");
}
