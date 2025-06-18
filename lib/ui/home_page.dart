import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class Home_Page extends StatefulWidget {
  const Home_Page({super.key});

  @override
  State<Home_Page> createState() => _Home_PageState();
}

Color backgroundColors = Colors.black54;
Color buttonColors = Colors.red;

Color textColors = Colors.white;
bool dark_still = true;
String Javob = "";
String qabul_qiluvchi = "";

class _Home_PageState extends State<Home_Page> {
  void _tugmabosilganda(String value) {
    setState(() {
      if (value == "del") {
        qabul_qiluvchi = qabul_qiluvchi.substring(0, qabul_qiluvchi.length - 1);
      } else if (value == "C") {
        Javob = "";
        qabul_qiluvchi = "";
      } else if (value == "=") {
        try {
          Parser p = Parser();
          Expression exp = p.parse(
            qabul_qiluvchi.replaceAll('x', '*').replaceAll('%', '/'),
          );
          ContextModel cm = ContextModel();

          double eval = exp.evaluate(EvaluationType.REAL, cm);
          Javob = eval.toString();
        } catch (e) {
          Javob = "Error";
        }
      } else {
        qabul_qiluvchi += value;
      }
    });
  }

  void dark_light_still() {
    setState(() {
      dark_still = !dark_still;
      backgroundColors = dark_still ? Colors.black54 : Colors.white;
      buttonColors = dark_still ? Colors.red : Colors.blue;
      textColors = dark_still ? Colors.white : Colors.black;
    });
  }

  Widget _buttonsCalculator(String text, {Color? color}) {
    return Container(
      height: 80,
      width: 80,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: color,
      ),
      child: InkWell(
        onTap: () {
          setState(() {
            _tugmabosilganda(text);
          });
        },
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 20,
              color: textColors,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Calculator',
          style: TextStyle(
            fontSize: 24,
            color: textColors,
            fontWeight: FontWeight.w700,
          ),
        ),
        backgroundColor: backgroundColors,
        actions: [
          IconButton(
            onPressed: () {
              dark_light_still();
            },
            icon: Icon(dark_still ? Icons.light_mode : Icons.dark_mode),
            color: dark_still ? Colors.white : Colors.black,
          ),
        ],
      ),
      backgroundColor: backgroundColors,
      body: Padding(
        padding: EdgeInsets.all(24),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      textAlign: TextAlign.end,
                      qabul_qiluvchi.toString(),
                      style: TextStyle(fontSize: 18, color: textColors),
                    ),
                    SizedBox(height: 20),
                    Text(
                      textAlign: TextAlign.end,
                      Javob.toString(),
                      style: TextStyle(fontSize: 24, color: textColors),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 89),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buttonsCalculator('C', color: buttonColors),
                _buttonsCalculator('/', color: buttonColors),
                _buttonsCalculator('*', color: buttonColors),
                _buttonsCalculator('del', color: buttonColors),
              ],
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buttonsCalculator('7', color: buttonColors),
                _buttonsCalculator('8', color: buttonColors),
                _buttonsCalculator('9', color: buttonColors),
                _buttonsCalculator('-', color: buttonColors),
              ],
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buttonsCalculator('4', color: buttonColors),
                _buttonsCalculator('5', color: buttonColors),
                _buttonsCalculator('6', color: buttonColors),
                _buttonsCalculator('+', color: buttonColors),
              ],
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buttonsCalculator('1', color: buttonColors),
                        SizedBox(width: 9),
                        _buttonsCalculator('2', color: buttonColors),
                        SizedBox(width: 9),
                        _buttonsCalculator('3', color: buttonColors),
                      ],
                    ),
                    SizedBox(height: 10),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buttonsCalculator('%', color: buttonColors),
                        SizedBox(width: 9),
                        _buttonsCalculator('0', color: buttonColors),
                        SizedBox(width: 9),
                        _buttonsCalculator(',', color: buttonColors),
                      ],
                    ),
                  ],
                ),
                SizedBox(width: 4),
                Container(
                  height: 170,
                  width: 80,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: buttonColors,
                  ),
                  child: Center(
                    child: _buttonsCalculator('=', color: buttonColors),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
