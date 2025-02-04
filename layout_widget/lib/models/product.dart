// produt1~product10.png
class Product {
  String? image;        // 상품 이미지
  String? title;        // 상품명
  String? description;  // 상품 설명

  // 생성자
  Product(
    {
      required this.image,
      required this.title,
      this.description
    }
  );

}