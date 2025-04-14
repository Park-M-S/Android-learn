import 'package:flutter/material.dart';

class TestCheckbox extends StatefulWidget {
  const TestCheckbox({super.key});

  @override
  State<TestCheckbox> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<TestCheckbox> {
  bool? isChecked1 = false;
  bool isChecked2 = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text('CheckBox / Switch 테스트'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Checkbox(
              value: isChecked1,
              onChanged: (value) {
                setState(() {
                  isChecked1 = value;
                });
              },
            ),
            Text('$isChecked1'),

            SizedBox(height: 80),

            Switch(
              value: isChecked2,
              onChanged: (value) {
                setState(() {
                  isChecked2 = value;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
