import 'package:flutter/material.dart';

class TestTextField extends StatelessWidget {
  const TestTextField({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('TextField 테스트')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextField(),

          SizedBox(height: 40),

          TextField(decoration: InputDecoration(labelText: '여기에 입력하세요')),

          SizedBox(height: 40),

          TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: '여기에 입력하세요',
            ),
          ),
        ],
      ),
    );
  }
}
