import 'package:b_6_first/person.dart';
import 'package:b_6_first/second_page.dart';
import 'package:flutter/material.dart';

class FirstPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('FirstPage'),
      ),
      body: Container(
        color: Colors.red,
      ),
      floatingActionButton: ElevatedButton(onPressed: () async {
        final person = Person('홍길동', 20);

        var result = await Navigator.pushNamed(context,
            '/second'
        );
      }, child: Text('다음 페이지로')),
    );
  }
}