import 'package:flutter/material.dart';
import 'package:layout_widget/models/product.dart';
import 'package:layout_widget/screens/detail_screen.dart';

class ListviewScreen extends StatefulWidget {
  const ListviewScreen({super.key});

  @override
  State<ListviewScreen> createState() => _ListviewScreenState();
}

class _ListviewScreenState extends State<ListviewScreen> {
  List<Widget> productWidgetList = [
    ListTile(
      leading: Image.asset("image/no-image.jpg"),
      title: Text("상품명"),
      subtitle: Text("상품 설명"),
      trailing: Icon(Icons.more_vert),
      onTap: () => {print("아이템 클릭")},
    )
  ];

  // 동적 상품 객체 리스트
  final List<Product> productList = List.generate(
      10,
      (index) => Product(
          image: index == 1 ? null : "image/product${index + 1}.jpg",
          title: "상품 제목${index + 1}",
          description: "상품${index + 1}의 설명입니다."));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("리스트 뷰"),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 0),
        child: Center(
            child:
                // 기본 리스트뷰
                // ListView(
                //   children: productList,
                // ),
                //
                // 동적 리스트 생성
                ListView.builder(
                    itemCount: productList.length, // 반복될 아이템 수
                    itemBuilder: (context, index) {
                      final product = productList[index];
                      return ListTile(
                        leading: Image.asset(
                          product.image ?? "image/no-image.jpg",
                          width: 50,
                        ),
                        title: Text(product.title ?? "상품명"),
                        subtitle: Text(product.description ?? "상품 설명"),
                        trailing: Icon(Icons.more_vert),
                        onTap: () {
                          print("아이템 클릭");
                          AlertDialog dialog = AlertDialog(
                            content: Text(
                              "상품명 ${product.title}",
                              style: TextStyle(fontSize: 20.0),
                            ),
                            actions: [
                              TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();

                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => DetailScreen(
                                                  product: product,
                                                )));
                                  },
                                  child: const Text("확인"))
                            ],
                          );
                          showDialog(
                              context: context,
                              builder: (BuildContext context) => dialog);
                        },
                      );
                    })),
      ),
    );
  }
}
