import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SayisalLoto extends StatefulWidget {
  const SayisalLoto({super.key});

  @override
  State<SayisalLoto> createState() => _SayisalLotoState();
}

int cevap = 0;

class _SayisalLotoState extends State<SayisalLoto> {
  Random random = Random();

  num bakiye = 10;
  int kazanilanPara = 0;
  List<int> sistem = [];
  List<int> oyuncu = [];
  String sayicontrol = "";
  var sayi1 = 0, sayi2 = 0, sayi3 = 0, sayi4 = 0, sayi5 = 0, sayi6 = 0;

  final sayi1Controller = TextEditingController();
  final sayi2Controller = TextEditingController();
  final sayi3Controller = TextEditingController();
  final sayi4Controller = TextEditingController();
  final sayi5Controller = TextEditingController();
  final sayi6Controller = TextEditingController();
  playerNumbersRandom() {
    List<int> numbers = [];
    Random rand = Random();
    while (numbers.length < 6) {
      int num = rand.nextInt(61);
      if (!numbers.contains(num)) {
        numbers.add(num);
      }
    }
    sayi1Controller.text = numbers[0].toString();
    sayi2Controller.text = numbers[1].toString();
    sayi3Controller.text = numbers[2].toString();
    sayi4Controller.text = numbers[3].toString();
    sayi5Controller.text = numbers[4].toString();
    sayi6Controller.text = numbers[5].toString();
    setState(() {
      oyuncu = numbers;
    });
  }

  systemNumbersRandom() {
    List<int> numbers = [];
    Random rand = Random();
    while (numbers.length < 6) {
      int num = rand.nextInt(61);
      if (!numbers.contains(num)) {
        numbers.add(num);
      }
    }
    setState(() {
      sistem = numbers;
    });
  }

  void odulSistemi() {
    switch (cevap) {
      case 1:
        kazanilanPara = 10;
        bakiye += kazanilanPara;
        break;
      case 2:
        kazanilanPara = 15;
        bakiye += kazanilanPara;
        break;
      case 3:
        kazanilanPara = 20;
        bakiye += kazanilanPara;
        break;
      case 4:
        kazanilanPara = 30;
        bakiye += kazanilanPara;
        break;
      case 5:
        kazanilanPara = 40;
        bakiye += kazanilanPara;
        break;
      case 6:
        kazanilanPara = 100;
        bakiye += kazanilanPara;
        break;
      default:
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sayisal Loto"),
        actions: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                bakiye.toString(),
                style: TextStyle(fontSize: 25),
              ),
            ],
          ),
          SizedBox(width: 10),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                TextFormField(
                  inputFormatters: [
                    CustomRangeTextInputFormatter(),
                  ],
                  keyboardType: TextInputType.number,
                  controller: sayi1Controller,
                  decoration: const InputDecoration(
                    hintText: "1. Sayı",
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 10),
                TextFormField(
                  keyboardType: TextInputType.number,
                  controller: sayi2Controller,
                  inputFormatters: [
                    CustomRangeTextInputFormatter(),
                  ],
                  decoration: const InputDecoration(
                    hintText: "2. Sayı",
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 10),
                TextFormField(
                  keyboardType: TextInputType.number,
                  controller: sayi3Controller,
                  inputFormatters: [
                    CustomRangeTextInputFormatter(),
                  ],
                  decoration: const InputDecoration(
                    hintText: "3. Sayı",
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 10),
                TextFormField(
                  keyboardType: TextInputType.number,
                  controller: sayi4Controller,
                  inputFormatters: [
                    CustomRangeTextInputFormatter(),
                  ],
                  decoration: const InputDecoration(
                    hintText: "4. Sayı",
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 10),
                TextFormField(
                  keyboardType: TextInputType.number,
                  controller: sayi5Controller,
                  inputFormatters: [
                    CustomRangeTextInputFormatter(),
                  ],
                  decoration: const InputDecoration(
                    hintText: "5. Sayı",
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 10),
                TextFormField(
                  keyboardType: TextInputType.number,
                  controller: sayi6Controller,
                  inputFormatters: [
                    CustomRangeTextInputFormatter(),
                  ],
                  decoration: const InputDecoration(
                    hintText: "6. Sayı",
                    border: OutlineInputBorder(),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    playerNumbersRandom();
                  });
                },
                child: Text(
                  "Rastgele Sayılar Üret",
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ),
          ),
          SizedBox(height: 8),
          Padding(
            padding: EdgeInsets.only(left: 10, right: 10),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  if (bakiye == 0) {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        content: Text("Bakiyen yetersiz"),
                      ),
                    );
                  } else if (oyuncu.isEmpty) {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        content: Text("Altı tane sayı girmeniz gerekiyor"),
                      ),
                    );
                  } else {
                    oyuncu = [
                      int.parse(sayi1Controller.text),
                      int.parse(sayi2Controller.text),
                      int.parse(sayi3Controller.text),
                      int.parse(sayi4Controller.text),
                      int.parse(sayi5Controller.text),
                      int.parse(sayi6Controller.text),
                    ];
                    systemNumbersRandom();
                    cevap = 0;
                    for (int i = 0; i < 6; i++) {
                      if (oyuncu[i] == sistem[i]) {
                        print("sistem:" + sistem.toString());
                        cevap = cevap + 1;
                      }
                    }
                    print("Doğru sayısı:" + cevap.toString());
                    odulSistemi();
                    setState(() {
                      bakiye--;
                    });
                  }
                },
                child: Text(
                  "Oyna",
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ),
          ),
          SizedBox(height: 25),
          Text(
            "Kullanıcı: " + oyuncu.toString(),
            style: TextStyle(fontSize: 22),
          ),
          Text(
            "Sistem: " + sistem.toString(),
            style: TextStyle(fontSize: 22), // arttı para
          ),
          Text(
            "Doğru sayısı: " + cevap.toString(),
            style: TextStyle(fontSize: 22),
          ),
        ],
      ),
    );
  }
}









class CustomRangeTextInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (newValue.text == '') {
      return const TextEditingValue();
    } else if (int.parse(newValue.text) < 0) {
      return const TextEditingValue().copyWith(text: '1');
    }

    return int.parse(newValue.text) > 60
        ? const TextEditingValue().copyWith(text: '60')
        : newValue;
  }
}
