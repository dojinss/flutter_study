import 'package:flutter/material.dart';
import 'package:layout_widget/models/product.dart';
import 'package:layout_widget/screens/detail_screen.dart';

// 동적 상품 객체 리스트
final List<Product> productList = List.generate(
  10,
  (index) => Product(
    image: index == 1 ? null : "image/product${index + 1}.jpg",
    title: "상품 제목${index + 1}",
    description: "상품${index + 1}의 설명",
  ),
);

class GridviewScreen extends StatelessWidget {
  const GridviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("그리드 뷰")),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10.0,
          mainAxisSpacing: 10.0,
        ),
        itemCount: productList.length,
        itemBuilder: (context, index) {
          final product = productList[index];
          return GestureDetector(
            onTap: () => _onProductTap(context, product),
            child: buildGridTile(product),
          );
        },
      ),
    );
  }

  Widget buildGridTile(Product product) {
    return Card(
      elevation: 4,
      child: GridTile(
        header: _buildHeader(),
        footer: _buildFooter(product),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: Image.asset(
            product.image ?? "image/no-image.jpg",
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: const [
        Padding(
          padding: EdgeInsets.all(10.0),
          child: Icon(Icons.more_vert),
        ),
      ],
    );
  }

  Widget _buildFooter(Product product) {
    return Column(
      children: [
        Text(product.title ?? "상품 제목"),
        Text(product.description ?? "상품 설명"),
      ],
    );
  }

  void _onProductTap(BuildContext context, Product product) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Text(
          "상품명: ${product.title}",
          style: const TextStyle(fontSize: 20.0),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailScreen(product: product),
                ),
              );
            },
            child: const Text("확인"),
          ),
        ],
      ),
    );
  }
}
