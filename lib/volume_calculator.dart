import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class VolumeCalculatorPage extends StatefulWidget {
  @override
  _VolumeCalculatorPageState createState() => _VolumeCalculatorPageState();
}

class _VolumeCalculatorPageState extends State<VolumeCalculatorPage> {
  String selectedShape = "Balok";
  final TextEditingController lengthController = TextEditingController();
  final TextEditingController widthController = TextEditingController();
  final TextEditingController heightController = TextEditingController();
  final TextEditingController radiusController = TextEditingController();
  double volume = 0;

  void calculateVolume() {
    setState(() {
      if (selectedShape == "Balok") {
        double length = double.tryParse(lengthController.text) ?? 0;
        double width = double.tryParse(widthController.text) ?? 0;
        double height = double.tryParse(heightController.text) ?? 0;
        volume = length * width * height;
      } else if (selectedShape == "Piramida") {
        double base = double.tryParse(lengthController.text) ?? 0;
        double height = double.tryParse(heightController.text) ?? 0;
        volume = (1 / 3) * base * base * height;
      } else if (selectedShape == "Tabung") {
        double radius = double.tryParse(radiusController.text) ?? 0;
        double height = double.tryParse(heightController.text) ?? 0;
        volume = 3.1416 * radius * radius * height;
      }
    });
  }

  void resetCalculator() {
    setState(() {
      volume = 0;
      lengthController.clear();
      widthController.clear();
      heightController.clear();
      radiusController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Volume Calculator")),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  "Pilih Bentuk",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _shapeButton("Balok", FontAwesomeIcons.cube),
                  _shapeButton("Piramida", FontAwesomeIcons.landmarkDome),
                  _shapeButton("Tabung", FontAwesomeIcons.database),
                ],
              ),
              SizedBox(height: 20),
              if (selectedShape == "Balok" || selectedShape == "Piramida")
                _inputField("Panjang/Alas", lengthController),
              if (selectedShape == "Balok")
                _inputField("Lebar", widthController),
              if (selectedShape == "Balok" ||
                  selectedShape == "Piramida" ||
                  selectedShape == "Tabung")
                _inputField("Tinggi", heightController),
              if (selectedShape == "Tabung")
                _inputField("Jari-Jari", radiusController),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: calculateVolume,
                    child: Text("Hitung Volume"),
                  ),
                  ElevatedButton(
                    onPressed: resetCalculator,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                    ),
                    child: Text("Reset", style: TextStyle(color: Colors.white)),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Center(
                child: Text(
                  "Volume: $volume",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _shapeButton(String label, IconData icon) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedShape = label;
          resetCalculator();
        });
      },
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: selectedShape == label ? Colors.green : Colors.grey[300],
            ),
            padding: EdgeInsets.all(15),
            child: FaIcon(icon, size: 40, color: Colors.white),
          ),
          SizedBox(height: 5),
          Text(label, style: TextStyle(fontSize: 16)),
        ],
      ),
    );
  }

  Widget _inputField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(),
        ),
        keyboardType: TextInputType.number,
      ),
    );
  }
}
