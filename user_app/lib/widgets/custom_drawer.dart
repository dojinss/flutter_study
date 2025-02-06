import 'package:flutter/material.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 255, 60, 0),
              image: DecorationImage(
                image: AssetImage('/logo.jpg'),
              ),
            ),
            child: Text(
              "프리오더 - 주문",
              style: TextStyle(color: Colors.white),
            ),
          ),
          ListTile(
            leading: const Icon(
              Icons.home,
              size: 36,
              weight: 300,
            ),
            title: Text(
              "홈으로",
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/home');
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.login,
              size: 36,
              weight: 300,
            ),
            title: Text(
              "로그인",
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/login');
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.person,
              size: 36,
              weight: 300,
            ),
            title: Text(
              "마이페이지",
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/mypage');
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.logout,
              size: 36,
              weight: 300,
            ),
            title: Text(
              "로그아웃",
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            onTap: () {
              // TODO : 로그아웃처리
            },
          ),
        ],
      ),
    );
  }
}
