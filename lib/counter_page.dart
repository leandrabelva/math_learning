import 'package:flutter/material.dart';

class CounterPage extends StatefulWidget {
  @override
  _CounterPageState createState() => _CounterPageState();
}

class _CounterPageState extends State<CounterPage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void _decrementCounter() {
    setState(() {
      _counter--; // Bisa kurang dari 0
    });
  }

  void _resetCounter() {
    setState(() {
      _counter = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Counter")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Counter Value:', style: TextStyle(fontSize: 20)),
            Text(
              '$_counter',
              style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: _decrementCounter,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                  ),
                  child: Text(
                    "-",
                    style: TextStyle(color: Colors.white, fontSize: 24),
                  ),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: _incrementCounter,
                  child: Text("+", style: TextStyle(fontSize: 24)),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: _resetCounter,
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                  child: Text("Reset", style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
