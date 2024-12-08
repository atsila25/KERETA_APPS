import 'package:flutter/material.dart';

class Callback extends StatefulWidget {
  const Callback({Key? key}) : super(key: key);

  @override
  _Callback createState() => _Callback();
}

class _Callback extends State<Callback> {
  double _sliderValue = 50; // Menyimpan nilai slider
  bool _switchValue = true; // Menyimpan

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const SizedBox(
              height: 20), // Menambahkan jarak antara Dropdown dan Button
          ElevatedButton(
            onPressed: () {
              print('Tombol ditekan!'); // Menampilkan teks saat tombol ditekan
            },
            child: const Text('Klik Saya'), // Teks pada tombol
          ),
          Slider(
            value: _sliderValue,
            min: 0,
            max: 100,
            onChanged: (double newValue) {
              setState(() {
                _sliderValue = newValue;
                print('Nilai slider: $newValue');
              });
            },
          ),
          Switch(
            value: _switchValue,
            onChanged: (bool newValue) {
              setState(() {
                _switchValue = newValue;
              print('Switch is now: $newValue');
              });
            },
          ),
        ],
      ),
    );
  }
}

void main() {
  runApp(const MaterialApp(
    home: Scaffold(
      body: Center(
        child: Callback(),
      ),
    ),
  ));
}
