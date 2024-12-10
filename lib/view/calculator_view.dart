import 'package:flutter/material.dart';

class CalculatorView extends StatefulWidget {
  const CalculatorView({super.key});

  @override
  State<CalculatorView> createState() => _CalculatorViewState();
}

class _CalculatorViewState extends State<CalculatorView> {
  final _textController = TextEditingController();
  List<String> lstSymbols = [
    "C",
    "*",
    "/",
    "<-",
    "1",
    "2",
    "3",
    "+",
    "4",
    "5",
    "6",
    "-",
    "7",
    "8",
    "9",
    "*",
    "%",
    "0",
    ".",
    "=",
  ];

  String input = "";
  double? firstOperand;
  double? secondOperand;
  String? operation;
  String history = ""; // Store the history in a single string

  void _onButtonPressed(String symbol) {
    setState(() {
      if (symbol == "C") {
        // Clear the input and history
        input = "";
        firstOperand = null;
        secondOperand = null;
        operation = null;
        history = ""; // Reset history
      } else if (symbol == "<-") {
        // Backspace
        if (input.isNotEmpty) {
          input = input.substring(0, input.length - 1);
        }
      } else if (symbol == "=") {
        // Calculate the result
        if (firstOperand != null && operation != null && input.isNotEmpty) {
          secondOperand = double.tryParse(input);
          if (secondOperand != null) {
            String result = "";
            switch (operation) {
              case "+":
                result = (firstOperand! + secondOperand!).toString();
                break;
              case "-":
                result = (firstOperand! - secondOperand!).toString();
                break;
              case "*":
                result = (firstOperand! * secondOperand!).toString();
                break;
              case "/":
                result = secondOperand != 0
                    ? (firstOperand! / secondOperand!).toString()
                    : "Error";
                break;
              case "%":
                result = (firstOperand! % secondOperand!).toString();
                break;
              default:
                break;
            }
            // Add to history
            history += "$firstOperand $operation $secondOperand = $result\n";
            input = result;
          }
          firstOperand = null;
          operation = null;
        }
      } else if (["+", "-", "*", "/", "%"].contains(symbol)) {
        // Handle operators
        if (input.isNotEmpty) {
          firstOperand = double.tryParse(input);
          operation = symbol;
          input = "";
        }
      } else {
        // Append numbers and decimal point
        input += symbol;
      }
      // Update the text field to show both history and current input
      _textController.text = _buildTextWithHistory();
      // Ensure the cursor stays at the end
      _textController.selection = TextSelection.fromPosition(TextPosition(offset: _textController.text.length));
    });
  }

  // Helper function to build the text with history and input in different styles
  String _buildTextWithHistory() {
    String resultText = history;
    String inputText = input;

    // Display the history in smaller size and the result in a larger size
    return resultText + "\n" + inputText;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text(
              'Bipasha',
              style: TextStyle(fontSize: 18),
            ),
            Spacer(), // Pushes "Calculator App" to the center
            Text(
              'Calculator App',
              style: TextStyle(fontSize: 18),
            ),
            Spacer(), // Maintains symmetry
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            // Use Align widget to align text to the right
            Align(
              alignment: Alignment.centerRight,
              child: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: history, // History in small font
                      style: const TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                      ),
                    ),
                    TextSpan(
                      text: "\n", // Add space between history and input
                      style: const TextStyle(
                        fontSize: 10,
                        color: Colors.black,
                      ),
                    ),
                    TextSpan(
                      text: input, // Input in larger font
                      style: const TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 2),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  crossAxisSpacing: 8.0,
                  mainAxisSpacing: 8.0,
                ),
                itemCount: lstSymbols.length,
                itemBuilder: (context, index) {
                  return ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 152, 181, 204),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(0),
                      ),
                    ),
                    onPressed: () => _onButtonPressed(lstSymbols[index]),
                    child: Text(
                      lstSymbols[index],
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
