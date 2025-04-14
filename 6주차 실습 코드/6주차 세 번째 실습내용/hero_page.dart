import 'package:flutter/material.dart';
import 'package:b_6_3/hero_detail_page.dart';

class HeroPage extends StatelessWidget {
  const HeroPage({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Hero')),
      body: Center(
        child: GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const HeroDetailPage()),
            );
          },
          child: Hero(
            tag: 'image',
            child: Image.asset('asset/first.png', width: 100, height: 100),
          ),
        ),
      ),
    );
  }
}
