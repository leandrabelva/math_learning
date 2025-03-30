import 'package:flutter/material.dart';
import 'dart:math';

class AreaCalculatorPage extends StatefulWidget {
  @override
  _AreaCalculatorPageState createState() => _AreaCalculatorPageState();
}

class _AreaCalculatorPageState extends State<AreaCalculatorPage> {
  String _selectedShape = "Persegi";
  double _result = 0;
  final TextEditingController _firstController = TextEditingController();
  final TextEditingController _secondController = TextEditingController();

  void _calculateArea() {
    setState(() {
      double value1 = double.tryParse(_firstController.text) ?? 0;
      double value2 = double.tryParse(_secondController.text) ?? 0;

      if (_selectedShape == "Persegi") {
        _result = value1 * value1;
      } else if (_selectedShape == "Segitiga") {
        _result = 0.5 * value1 * value2;
      } else if (_selectedShape == "Lingkaran") {
        _result = pi * value1 * value1;
      }
    });
  }

  void _resetFields() {
    setState(() {
      _firstController.clear();
      _secondController.clear();
      _result = 0;
    });
  }

  Widget _buildShapeButton(String shape, IconData icon) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              _selectedShape = shape;
              _resetFields();
            });
          },
          child: Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: _selectedShape == shape ? Colors.blue : Colors.grey[300],
            ),
            child: Icon(icon, size: 40, color: Colors.white),
          ),
        ),
        SizedBox(height: 5),
        Text(
          shape,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Area Calculator")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Pilih Bentuk",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildShapeButton("Persegi", Icons.crop_square),
                _buildShapeButton("Segitiga", Icons.change_history),
                _buildShapeButton("Lingkaran", Icons.circle),
              ],
            ),
            SizedBox(height: 20),
            TextField(
              controller: _firstController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText:
                    _selectedShape == "Segitiga"
                        ? "Masukkan Alas"
                        : _selectedShape == "Lingkaran"
                        ? "Masukkan Jari-jari"
                        : "Masukkan Sisi",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            if (_selectedShape == "Segitiga")
              TextField(
                controller: _secondController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "Masukkan Tinggi",
                  border: OutlineInputBorder(),
                ),
              ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _calculateArea,
              child: Text("Hitung Luas"),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: _resetFields,
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              child: Text("Reset", style: TextStyle(color: Colors.white)),
            ),
            SizedBox(height: 20),
            Text(
              "Luas: ${_result.toStringAsFixed(2)}",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
