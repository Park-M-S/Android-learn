// pubspec.yaml 파일에 다음 의존성을 추가하세요:
/*
dependencies:
  flutter:
    sdk: flutter
*/

// lib/main.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '실시간 환율 계산기',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _amountController = TextEditingController(text: '1000');
  String _fromCurrency = 'KRW';
  String _toCurrency = 'USD';
  double _convertedAmount = 0.0;

  // 통화 리스트
  final List<String> _currencies = ['KRW', 'USD', 'EUR', 'JPY', 'GBP', 'CNY'];

  // 2024년 말 기준 실제 환율 데이터 (KRW 기준)
  final Map<String, Map<String, dynamic>> _exchangeRates = {
    'USD': {
      'name': '미국 달러',
      'rate': 1450.0,  // 1 USD = 1450 KRW
      'buyingRate': 1435.0,
      'sellingRate': 1465.0,
    },
    'EUR': {
      'name': '유로',
      'rate': 1520.0,  // 1 EUR = 1520 KRW
      'buyingRate': 1505.0,
      'sellingRate': 1535.0,
    },
    'JPY': {
      'name': '일본 엔 (100엔)',
      'rate': 950.0,   // 100 JPY = 950 KRW
      'buyingRate': 940.0,
      'sellingRate': 960.0,
    },
    'GBP': {
      'name': '영국 파운드',
      'rate': 1830.0,  // 1 GBP = 1830 KRW
      'buyingRate': 1810.0,
      'sellingRate': 1850.0,
    },
    'CNY': {
      'name': '중국 위안',
      'rate': 200.0,   // 1 CNY = 200 KRW
      'buyingRate': 198.0,
      'sellingRate': 202.0,
    },
    'KRW': {
      'name': '한국 원',
      'rate': 1.0,     // 1 KRW = 1 KRW
      'buyingRate': 1.0,
      'sellingRate': 1.0,
    },
  };

  @override
  void initState() {
    super.initState();
    _updateConversion();
  }

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  void _updateConversion() {
    final amount = double.tryParse(_amountController.text) ?? 0;

    if (amount == 0) {
      setState(() {
        _convertedAmount = 0;
      });
      return;
    }

    double result = 0;

    if (_fromCurrency == 'KRW') {
      // KRW에서 다른 통화로 변환
      if (_toCurrency == 'KRW') {
        result = amount;
      } else {
        final toRate = _exchangeRates[_toCurrency]?['rate'] ?? 1;
        if (_toCurrency == 'JPY') {
          // JPY는 100엔 단위이므로 특별 처리
          result = (amount / toRate) * 100;
        } else {
          result = amount / toRate;
        }
      }
    } else if (_toCurrency == 'KRW') {
      // 다른 통화에서 KRW로 변환
      final fromRate = _exchangeRates[_fromCurrency]?['rate'] ?? 1;
      if (_fromCurrency == 'JPY') {
        // JPY는 100엔 단위이므로 특별 처리
        result = (amount / 100) * fromRate;
      } else {
        result = amount * fromRate;
      }
    } else {
      // 둘 다 외화인 경우 KRW를 거쳐서 변환
      final fromRate = _exchangeRates[_fromCurrency]?['rate'] ?? 1;
      final toRate = _exchangeRates[_toCurrency]?['rate'] ?? 1;

      double krwAmount;
      if (_fromCurrency == 'JPY') {
        krwAmount = (amount / 100) * fromRate;
      } else {
        krwAmount = amount * fromRate;
      }

      if (_toCurrency == 'JPY') {
        result = (krwAmount / toRate) * 100;
      } else {
        result = krwAmount / toRate;
      }
    }

    setState(() {
      _convertedAmount = result;
    });
  }

  void _swapCurrencies() {
    setState(() {
      final temp = _fromCurrency;
      _fromCurrency = _toCurrency;
      _toCurrency = temp;
      _updateConversion();
    });
  }

  String _formatCurrency(double amount) {
    return amount.toStringAsFixed(2).replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
          (Match m) => '${m[1]},',
    );
  }

  String _getExchangeRateInfo() {
    if (_fromCurrency == _toCurrency) {
      return '1 $_fromCurrency = 1 $_toCurrency';
    }

    double rate = 0;

    if (_fromCurrency == 'KRW') {
      final toRate = _exchangeRates[_toCurrency]?['rate'] ?? 1;
      if (_toCurrency == 'JPY') {
        rate = 100 / toRate;
      } else {
        rate = 1 / toRate;
      }
    } else if (_toCurrency == 'KRW') {
      final fromRate = _exchangeRates[_fromCurrency]?['rate'] ?? 1;
      if (_fromCurrency == 'JPY') {
        rate = fromRate / 100;
      } else {
        rate = fromRate;
      }
    } else {
      final fromRate = _exchangeRates[_fromCurrency]?['rate'] ?? 1;
      final toRate = _exchangeRates[_toCurrency]?['rate'] ?? 1;

      if (_fromCurrency == 'JPY' && _toCurrency != 'JPY') {
        rate = (fromRate / 100) / toRate;
      } else if (_fromCurrency != 'JPY' && _toCurrency == 'JPY') {
        rate = (fromRate / toRate) * 100;
      } else if (_fromCurrency == 'JPY' && _toCurrency == 'JPY') {
        rate = fromRate / toRate;
      } else {
        rate = fromRate / toRate;
      }
    }

    return '1 $_fromCurrency = ${rate.toStringAsFixed(4)} $_toCurrency';
  }

  String _getReverseExchangeRateInfo() {
    if (_fromCurrency == _toCurrency) {
      return '1 $_toCurrency = 1 $_fromCurrency';
    }

    double rate = 0;

    if (_toCurrency == 'KRW') {
      final fromRate = _exchangeRates[_fromCurrency]?['rate'] ?? 1;
      if (_fromCurrency == 'JPY') {
        rate = 100 / fromRate;
      } else {
        rate = 1 / fromRate;
      }
    } else if (_fromCurrency == 'KRW') {
      final toRate = _exchangeRates[_toCurrency]?['rate'] ?? 1;
      if (_toCurrency == 'JPY') {
        rate = toRate / 100;
      } else {
        rate = toRate;
      }
    } else {
      final fromRate = _exchangeRates[_fromCurrency]?['rate'] ?? 1;
      final toRate = _exchangeRates[_toCurrency]?['rate'] ?? 1;

      if (_toCurrency == 'JPY' && _fromCurrency != 'JPY') {
        rate = (toRate / 100) / fromRate;
      } else if (_toCurrency != 'JPY' && _fromCurrency == 'JPY') {
        rate = (toRate / fromRate) * 100;
      } else if (_toCurrency == 'JPY' && _fromCurrency == 'JPY') {
        rate = toRate / fromRate;
      } else {
        rate = toRate / fromRate;
      }
    }

    return '1 $_toCurrency = ${rate.toStringAsFixed(4)} $_fromCurrency';
  }

  Widget _buildCurrencyDropdown(String value, Function(String?) onChanged) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(4),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: DropdownButton<String>(
        value: value,
        icon: const Icon(Icons.arrow_drop_down),
        underline: Container(),
        items: _currencies.map<DropdownMenuItem<String>>((String currency) {
          return DropdownMenuItem<String>(
            value: currency,
            child: Text(currency),
          );
        }).toList(),
        onChanged: onChanged,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('실시간 환율 계산기'),
        centerTitle: true,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _amountController,
                            keyboardType: TextInputType.numberWithOptions(decimal: true),
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
                            ],
                            decoration: InputDecoration(
                              labelText: '금액',
                              border: OutlineInputBorder(),
                            ),
                            onChanged: (_) => _updateConversion(),
                          ),
                        ),
                        const SizedBox(width: 16),
                        _buildCurrencyDropdown(_fromCurrency, (value) {
                          if (value != null) {
                            setState(() {
                              _fromCurrency = value;
                              _updateConversion();
                            });
                          }
                        }),
                      ],
                    ),
                    const SizedBox(height: 16),
                    IconButton(
                      icon: const Icon(Icons.swap_vert),
                      onPressed: _swapCurrencies,
                      tooltip: '통화 교환',
                      style: IconButton.styleFrom(
                        backgroundColor: Colors.blue.shade100,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              _formatCurrency(_convertedAmount),
                              style: const TextStyle(fontSize: 18),
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        _buildCurrencyDropdown(_toCurrency, (value) {
                          if (value != null) {
                            setState(() {
                              _toCurrency = value;
                              _updateConversion();
                            });
                          }
                        }),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('환율 정보', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    Text(
                      _getExchangeRateInfo(),
                      style: const TextStyle(fontSize: 16),
                    ),
                    Text(
                      _getReverseExchangeRateInfo(),
                      style: const TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 8),
                    if (_fromCurrency != 'KRW') Text(
                      '통화 이름: ${_exchangeRates[_fromCurrency]?['name'] ?? _fromCurrency}',
                      style: const TextStyle(fontSize: 14, color: Colors.blue),
                    ),
                    if (_toCurrency != 'KRW') Text(
                      '통화 이름: ${_exchangeRates[_toCurrency]?['name'] ?? _toCurrency}',
                      style: const TextStyle(fontSize: 14, color: Colors.blue),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '마지막 업데이트: 2024-12-19 (참고용 환율)',
                      style: const TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: Card(
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('주요 통화 환율', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 8),
                      Expanded(
                        child: ListView.builder(
                          itemCount: _exchangeRates.length - 1, // KRW 제외
                          itemBuilder: (context, index) {
                            final currencies = _exchangeRates.keys.where((key) => key != 'KRW').toList();
                            final currencyCode = currencies[index];
                            final currency = _exchangeRates[currencyCode]!;

                            return ListTile(
                              title: Text('$currencyCode (${currency['name']})'),
                              subtitle: Text(
                                '매매기준율: ${_formatCurrency(currency['rate'])} 원${currencyCode == 'JPY' ? ' (100엔 기준)' : ''}',
                              ),
                              trailing: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text('살 때: ${_formatCurrency(currency['buyingRate'])} 원'),
                                  Text('팔 때: ${_formatCurrency(currency['sellingRate'])} 원'),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                _updateConversion();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('환율 계산 새로고침 완료')),
                );
              },
              child: const Text('환율 새로고침'),
            ),
          ],
        ),
      ),
    );
  }
}
