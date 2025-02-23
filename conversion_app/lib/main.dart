import 'package:flutter/material.dart';

void main() {
  runApp(ConversionApp());
}

class ConversionApp extends StatelessWidget {
  const ConversionApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Conversion App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ConversionScreen(),
    );
  }
}

class ConversionScreen extends StatefulWidget {
  const ConversionScreen({super.key});

  @override
  _ConversionScreenState createState() => _ConversionScreenState();
}

class _ConversionScreenState extends State<ConversionScreen> {
  String selectedUnitFrom = 'Miles';
  String selectedUnitTo = 'Kilometers';
  double inputValue = 0;
  double convertedValue = 0;

  final Map<String, double> conversionRates = {
    'Miles to Kilometers': 1.60934,
    'Kilometers to Miles': 0.621371,
    'Pounds to Kilograms': 0.453592,
    'Kilograms to Pounds': 2.20462,
  };

  void convert() {
    String conversionKey = '$selectedUnitFrom to $selectedUnitTo';
    if (conversionRates.containsKey(conversionKey)) {
      setState(() {
        convertedValue = inputValue * conversionRates[conversionKey]!;
      });
    } else {
      setState(() {
        convertedValue = 0;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Unit Converter'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            DropdownButton<String>(
              value: selectedUnitFrom,
              onChanged: (String? newValue) {
                setState(() {
                  selectedUnitFrom = newValue!;
                });
              },
              items: <String>['Miles', 'Kilometers', 'Pounds', 'Kilograms']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            SizedBox(height: 20),
            DropdownButton<String>(
              value: selectedUnitTo,
              onChanged: (String? newValue) {
                setState(() {
                  selectedUnitTo = newValue!;
                });
              },
              items: <String>['Miles', 'Kilometers', 'Pounds', 'Kilograms']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            SizedBox(height: 20),
            TextField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Enter Value',
                border: OutlineInputBorder(),
              ),
              onChanged: (String value) {
                setState(() {
                  inputValue = double.tryParse(value) ?? 0;
                });
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: convert,
              child: Text('Convert'),
            ),
            SizedBox(height: 20),
            Text(
            '$inputValue $selectedUnitFrom are $convertedValue $selectedUnitTo',
             style: TextStyle(fontSize: 20),
             ),
          ],
        ),
      ),
    );
  }
}