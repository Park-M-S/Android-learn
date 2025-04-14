import 'package:flutter/material.dart';

class HeroDetailPage extends StatelessWidget {
  const HeroDetailPage({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Hero Detail')),
      body: Hero(
        tag: 'image',
        child: Image.asset('asset/first.png', width: 100, height: 100),
      ),
    );
  }
}
