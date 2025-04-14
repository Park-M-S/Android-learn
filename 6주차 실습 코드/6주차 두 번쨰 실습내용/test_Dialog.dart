import 'package:flutter/material.dart';

class TestDialog extends StatelessWidget {
  const TestDialog({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('다이얼로그 테스트')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () {
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('제목'),
                    content: SingleChildScrollView(
                      child: ListBody(
                        children: [
                          Text('Alert Dialog입니다'),
                          Text('OS를 눌러 닫습니다'),
                        ],
                      ),
                    ),
                    actions: [
                      TextButton(
                        child: Text('Ok'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      TextButton(
                        child: Text('Cancel'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  );
                },
              );
            },
            child: Text('Alert Dialog 띄우기'),
          ),
        ],
      ),
    );
  }
}
