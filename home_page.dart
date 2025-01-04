import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Calculator(),
  ));
}

class Calculator extends StatefulWidget {
  const Calculator({super.key});

  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  // Controller for the two input text fields
  TextEditingController firstNumberController = TextEditingController();
  TextEditingController secondNumberController = TextEditingController();

  String result = ""; // Store the result
  String operator = ""; // Store the selected operator

  // Function to handle button press
  void buttonPressed(String value) {
    setState(() {
      if (value == "C") {
        // Clear button logic
        firstNumberController.clear();
        secondNumberController.clear();
        result = "";
        operator = "";
      } else if (value == "=") {
        // Equals button logic
        calculateResult();
      } else if (["+", "-", "*", "/"].contains(value)) {
        // Set the operator when an operator button is pressed
        operator = value;
      } else if (value == ".") {
        // Handle decimal point logic (to avoid multiple decimals)
        if (operator.isEmpty && !firstNumberController.text.contains(".")) {
          firstNumberController.text += value;
        } else if (operator.isNotEmpty &&
            !secondNumberController.text.contains(".")) {
          secondNumberController.text += value;
        }
      } else {
        // Add the pressed button value to the appropriate text field
        if (operator.isEmpty) {
          firstNumberController.text += value; // Append to first number
        } else {
          secondNumberController.text += value; // Append to second number
        }
      }
    });
  }

  // Function to calculate the result
  void calculateResult() {
    double firstNum = double.tryParse(firstNumberController.text) ?? 0.0;
    double secondNum = double.tryParse(secondNumberController.text) ?? 0.0;

    try {
      switch (operator) {
        case "+":
          setState(() {
            result = (firstNum + secondNum).toString();
          });
          break;
        case "-":
          setState(() {
            result = (firstNum - secondNum).toString();
          });
          break;
        case "*":
          setState(() {
            result = (firstNum * secondNum).toString();
          });
          break;
        case "/":
          setState(() {
            result =
                (secondNum != 0) ? (firstNum / secondNum).toString() : "Error";
          });
          break;
        default:
          setState(() {
            result = "Error";
          });
      }
    } catch (e) {
      setState(() {
        result = "Error";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text("Calculator", style: TextStyle(color: Colors.white)),
        ),
        backgroundColor: Colors.pink,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            // First Number TextField
            TextField(
              controller: firstNumberController,
              decoration: const InputDecoration(
                hintText: "Enter First Number",
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.all(20.0),
              ),
              style: const TextStyle(fontSize: 30),
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              textAlign: TextAlign.right,
            ),
            const SizedBox(height: 10),
            // Second Number TextField
            TextField(
              controller: secondNumberController,
              decoration: const InputDecoration(
                hintText: "Enter Second Number",
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.all(20.0),
              ),
              style: const TextStyle(fontSize: 30),
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              textAlign: TextAlign.right,
            ),
            const SizedBox(height: 10),
            // Display result with "Result" in front of the answer
            Text(
              result.isNotEmpty ? "Result: $result" : "",
              style: const TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            // Button grid (number and operator buttons)
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildButton("7"),
                    _buildButton("8"),
                    _buildButton("9"),
                    _buildButton("/"),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildButton("4"),
                    _buildButton("5"),
                    _buildButton("6"),
                    _buildButton("*"),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildButton("1"),
                    _buildButton("2"),
                    _buildButton("3"),
                    _buildButton("-"),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildButton("C"), // Clear Button
                    _buildButton("0"),
                    _buildButton("."), // decimal Button
                    _buildButton("+"),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildButton("=") // ans wala Button
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Button Builder
  Widget _buildButton(String value) {
    return ElevatedButton(
      onPressed: () {
        buttonPressed(value); // Handle button press
      },
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
        backgroundColor: Colors.pink,
        shape: const CircleBorder(),
      ),
      child: Text(
        value,
        style: const TextStyle(fontSize: 30, color: Colors.white),
      ),
    );
  }
}
