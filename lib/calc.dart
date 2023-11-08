import 'package:flutter/material.dart';

void main() {
  runApp(CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Calculator(),
    );
  }
}

class Calculator extends StatefulWidget {
  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  String _output = "0";
  String _currentNumber = "";
  String _operation = "";
  double _num1 = 0;

  void _onNumberClick(String text) {
    setState(() {
      _currentNumber += text;
      _output = _currentNumber;
    });
  }

  void _onOperationClick(String operation) {
    if (_currentNumber.isNotEmpty) {
      _num1 = double.parse(_currentNumber);
      _currentNumber = "";
      _operation = operation;
      _output = _num1.toString() + _operation;
    }
  }

  void _onEqualClick() {
    if (_currentNumber.isNotEmpty) {
      double num2 = double.parse(_currentNumber);
      double result = 0;
      switch (_operation) {
        case "+":
          result = _num1 + num2;
          break;
        case "-":
          result = _num1 - num2;
          break;
        case "*":
          result = _num1 * num2;
          break;
        case "/":
          result = _num1 / num2;
          break;
      }
      setState(() {
        _output = result.toStringAsFixed(2); // Wynik z dwoma miejscami po przecinku
        _num1 = result;
        _currentNumber = "";
        _operation = "";
      });
    }
  }

  void _onClearClick() {
    setState(() {
      _currentNumber = "";
      _output = "0";
      _num1 = 0;
      _operation = "";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Calculator"),
      ),
      body: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(16.0),
            alignment: Alignment.bottomRight,
            child: Text(
              _output,
              style: TextStyle(fontSize: 48.0),
            ),
          ),
          Expanded(
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    _buildButton("7"),
                    _buildButton("8"),
                    _buildButton("9"),
                    _buildButton("/"),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    _buildButton("4"),
                    _buildButton("5"),
                    _buildButton("6"),
                    _buildButton("*"),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    _buildButton("1"),
                    _buildButton("2"),
                    _buildButton("3"),
                    _buildButton("-"),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    _buildButton("C"),
                    _buildButton("0"),
                    _buildButton("="),
                    _buildButton("+"),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildButton(String text) {
    return Container(
      margin: EdgeInsets.all(10.0),
      child: ElevatedButton(
        onPressed: () {
          if (text == "C") {
            _onClearClick();
          } else if (text == "=") {
            _onEqualClick();
          } else if (text == "+" || text == "-" || text == "*" || text == "/") {
            _onOperationClick(text);
          } else {
            _onNumberClick(text);
          }
        },
        child: Text(
          text,
          style: TextStyle(fontSize: 24.0),
        ),
      ),
    );
  }
}
