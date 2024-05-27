import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: NumericalLottery(),
    ),
  );
}

class NumericalLottery extends StatefulWidget {
  const NumericalLottery({super.key});

  @override
  State<NumericalLottery> createState() => _NumericalLotteryState();
}

int answer = 0;

class _NumericalLotteryState extends State<NumericalLottery> {
  Random random = Random();

  num balance = 10;
  int wonMoney = 0;
  List<int> systemNumbers = [];
  List<int> playerNumbers = [];
  String numberValidation = "";
  var number1 = 0,
      number2 = 0,
      number3 = 0,
      number4 = 0,
      number5 = 0,
      number6 = 0;

  final number1Controller = TextEditingController();
  final number2Controller = TextEditingController();
  final number3Controller = TextEditingController();
  final number4Controller = TextEditingController();
  final number5Controller = TextEditingController();
  final number6Controller = TextEditingController();

  void generatePlayerNumbersRandom() {
    List<int> numbers = [];
    Random rand = Random();
    while (numbers.length < 6) {
      int num = rand.nextInt(61);
      if (!numbers.contains(num)) {
        numbers.add(num);
      }
    }
    number1Controller.text = numbers[0].toString();
    number2Controller.text = numbers[1].toString();
    number3Controller.text = numbers[2].toString();
    number4Controller.text = numbers[3].toString();
    number5Controller.text = numbers[4].toString();
    number6Controller.text = numbers[5].toString();
    setState(() {
      playerNumbers = numbers;
    });
  }

  void generateSystemNumbersRandom() {
    List<int> numbers = [];
    Random rand = Random();
    while (numbers.length < 6) {
      int num = rand.nextInt(61);
      if (!numbers.contains(num)) {
        numbers.add(num);
      }
    }
    setState(() {
      systemNumbers = numbers;
    });
  }

  void rewardSystem() {
    switch (answer) {
      case 1:
        wonMoney = 10;
        balance += wonMoney;
        break;
      case 2:
        wonMoney = 15;
        balance += wonMoney;
        break;
      case 3:
        wonMoney = 20;
        balance += wonMoney;
        break;
      case 4:
        wonMoney = 30;
        balance += wonMoney;
        break;
      case 5:
        wonMoney = 40;
        balance += wonMoney;
        break;
      case 6:
        wonMoney = 100;
        balance += wonMoney;
        break;
      default:
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Numerical Lottery"),
        actions: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                balance.toString(),
                style: const TextStyle(fontSize: 25),
              ),
            ],
          ),
          const SizedBox(width: 10),
        ],
      ),
      body: Scaffold(
        body: SingleChildScrollView(
          child: Column(
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
                      controller: number1Controller,
                      decoration: const InputDecoration(
                        hintText: "1. Number",
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      keyboardType: TextInputType.number,
                      controller: number2Controller,
                      inputFormatters: [
                        CustomRangeTextInputFormatter(),
                      ],
                      decoration: const InputDecoration(
                        hintText: "2. Number",
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      keyboardType: TextInputType.number,
                      controller: number3Controller,
                      inputFormatters: [
                        CustomRangeTextInputFormatter(),
                      ],
                      decoration: const InputDecoration(
                        hintText: "3. Number",
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      keyboardType: TextInputType.number,
                      controller: number4Controller,
                      inputFormatters: [
                        CustomRangeTextInputFormatter(),
                      ],
                      decoration: const InputDecoration(
                        hintText: "4. Number",
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      keyboardType: TextInputType.number,
                      controller: number5Controller,
                      inputFormatters: [
                        CustomRangeTextInputFormatter(),
                      ],
                      decoration: const InputDecoration(
                        hintText: "5. Number",
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      keyboardType: TextInputType.number,
                      controller: number6Controller,
                      inputFormatters: [
                        CustomRangeTextInputFormatter(),
                      ],
                      decoration: const InputDecoration(
                        hintText: "6. Number",
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
                        generatePlayerNumbersRandom();
                      });
                    },
                    child: const Text(
                      "Generate Random Numbers",
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      if (balance == 0) {
                        showDialog(
                          context: context,
                          builder: (context) => const AlertDialog(
                            content: Text("Insufficient balance"),
                          ),
                        );
                      } else if (playerNumbers.isEmpty) {
                        showDialog(
                          context: context,
                          builder: (context) => const AlertDialog(
                            content: Text("You need to enter six numbers"),
                          ),
                        );
                      } else {
                        playerNumbers = [
                          int.parse(number1Controller.text),
                          int.parse(number2Controller.text),
                          int.parse(number3Controller.text),
                          int.parse(number4Controller.text),
                          int.parse(number5Controller.text),
                          int.parse(number6Controller.text),
                        ];
                        generateSystemNumbersRandom();
                        answer = 0;
                        for (int i = 0; i < 6; i++) {
                          if (playerNumbers[i] == systemNumbers[i]) {
                            print("system:" + systemNumbers.toString());
                            answer = answer + 1;
                          }
                        }
                        print("Correct number:" + answer.toString());
                        rewardSystem();
                        setState(() {
                          balance--;
                        });
                      }
                    },
                    child: const Text(
                      "Play",
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 25),
              Text(
                "Player: " + playerNumbers.toString(),
                style: const TextStyle(fontSize: 22),
              ),
              Text(
                "System: " + systemNumbers.toString(),
                style: const TextStyle(fontSize: 22),
              ),
              Text(
                "Correct numbers: " + answer.toString(),
                style: const TextStyle(fontSize: 22),
              ),
            ],
          ),
        ),
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
