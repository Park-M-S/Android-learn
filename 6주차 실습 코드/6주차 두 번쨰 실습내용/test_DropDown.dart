import 'package:flutter/material.dart';

class TestDropdown extends StatefulWidget {
  const TestDropdown({super.key});

  @override
  State<TestDropdown> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<TestDropdown> {
  final _valueList = ['첫 번째', '두 번째', '세 번째'];
  String? _selectedValue = '첫 번째';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text('DropDownButton 테스트'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            DropdownButton(
              value: _selectedValue,
              items:
                  _valueList.map((value) {
                    return DropdownMenuItem(value: value, child: Text(value));
                  }).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedValue = value;
                });
              },
            ),
            Text('선택된 항목은 $_selectedValue 입니다!'),
          ],
        ),
      ),
    );
  }
}
