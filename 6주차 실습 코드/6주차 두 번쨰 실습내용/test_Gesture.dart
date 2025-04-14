import 'package:flutter/material.dart';

class TestGesture extends StatelessWidget {
  const TestGesture({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('GestureDetector, InkWell 테스트')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                print('GestureDetector 클릭!');
              },
              child: Text('클릭 Me!'),
            ),

            SizedBox(height: 80),

            InkWell(
              onTap: () {
                print('InkWell 클릭!');
              },
              child: Text('클릭 Me too!'),
            ),
          ],
        ),
      ),
    );
  }
}
