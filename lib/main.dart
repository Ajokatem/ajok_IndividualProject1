
import 'package:flutter/material.dart';

void main() {
  runApp(TemperatureConversionApp());
}

class TemperatureConversionApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Temperature Conversion App',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: TemperatureConverter(),
    );
  }
}

class TemperatureConverter extends StatefulWidget {
  @override
  _TemperatureConverterState createState() => _TemperatureConverterState();
}

class _TemperatureConverterState extends State<TemperatureConverter> {
  String _conversionType = 'F to C'; // Default conversion selected
  final TextEditingController _tempController = TextEditingController();
  String _result = '';
  List<String> _history = [];

  void _convertTemperature() {
    final String input = _tempController.text;
    if (input.isEmpty) return;

    double temperature = double.tryParse(input) ?? 0;

    String conversionResult;

    // Apply conversion formulas
    if (_conversionType == 'F to C') {
      double celsius = (temperature - 32) * 5 / 9;
      conversionResult = '${temperature.toStringAsFixed(2)} °F => ${celsius.toStringAsFixed(2)} °C';
    } else {
      double fahrenheit = (temperature * 9 / 5) + 32;
      conversionResult = '${temperature.toStringAsFixed(2)} °C => ${fahrenheit.toStringAsFixed(2)} °F';
    }

    // Update state with result and history
    setState(() {
      _result = conversionResult;
      _history.add(conversionResult);
    });

    _tempController.clear(); // Clear input after conversion
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Temperature Converter')),
      backgroundColor: Colors.lightBlue[50], // Light background color for consistency
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Conversion type selection with radio buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Radio<String>(
                  value: 'F to C',
                  groupValue: _conversionType,
                  onChanged: (value) {
                    setState(() {
                      _conversionType = value!;
                    });
                  },
                ),
                const Text('Fahrenheit to Celsius'),
                Radio<String>(
                  value: 'C to F',
                  groupValue: _conversionType,
                  onChanged: (value) {
                    setState(() {
                      _conversionType = value!;
                    });
                  },
                ),
                const Text('Celsius to Fahrenheit'),
              ],
            ),
            // Input field for temperature
            TextField(
              controller: _tempController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Enter temperature',
              ),
              style: const TextStyle(fontSize: 20), // Font size increased for readability
            ),
            const SizedBox(height: 20),
            // Convert button
            ElevatedButton(
              onPressed: _convertTemperature,
              child: const Text('Convert', style: TextStyle(fontSize: 18)),
            ),
            const SizedBox(height: 20),
            // Display conversion result
            Text(
              _result.isNotEmpty ? 'Result: $_result' : 'No result yet.',
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            // Conversion history
            const Text(
              'Conversion History:',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: _history.isNotEmpty
                  ? ListView.builder(
                itemCount: _history.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(
                      _history[index],
                      style: const TextStyle(fontSize: 18),
                    ),
                  );
                },
              )
                  : const Center(child: Text('No conversions yet.', style: TextStyle(fontSize: 18))),
            ),
          ],
        ),
      ),
    );
  }
}
