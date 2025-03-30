import 'package:flutter/material.dart';
import 'counter_page.dart';
import 'area_calculator.dart';
import 'volume_calculator.dart';

class MainActivity extends StatefulWidget {
  final String userName;

  const MainActivity({Key? key, required this.userName}) : super(key: key);

  @override
  _MainActivityState createState() => _MainActivityState();
}

class _MainActivityState extends State<MainActivity> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    CounterPage(),
    AreaCalculatorPage(),
    VolumeCalculatorPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Halo, ${widget.userName}'),
        backgroundColor: Colors.blue,
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
        ),
      ),
      body: _pages[_selectedIndex], // ✅ Display correct page
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.add), label: "Counter"),
          BottomNavigationBarItem(icon: Icon(Icons.square_foot), label: "Area"),
          BottomNavigationBarItem(
            icon: Icon(Icons.view_in_ar),
            label: "Volume",
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        onTap: _onItemTapped,
      ),
    );
  }
}
