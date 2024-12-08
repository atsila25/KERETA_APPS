import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Multiple Input Widgets'),
        ),
        body: const Padding(
          padding: EdgeInsets.all(16.0),
          child: InputFormWidget(),
        ),
      ),
    );
  }
}

class InputFormWidget extends StatefulWidget {
  const InputFormWidget({Key? key}) : super(key: key);

  @override
  _InputFormWidgetState createState() => _InputFormWidgetState();
}

class _InputFormWidgetState extends State<InputFormWidget> {
  // Variabel untuk menyimpan nilai input pengguna
  String _name = '';
  double _sliderValue = 0;
  bool _isSwitched = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        // TextField untuk input nama
        TextField(
          decoration: const InputDecoration(
            labelText: 'Nama',
            border: OutlineInputBorder(),
          ),
          onChanged: (text) {
            setState(() {
              _name = text;
            });
          },
        ),
        const SizedBox(height: 20), // Jarak antara input

        // Slider untuk memilih nilai
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Pilih Nilai (0 - 100)',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Slider(
              value: _sliderValue,
              min: 0,
              max: 100,
              divisions: 100, // Membagi slider menjadi 100 bagian
              label: _sliderValue.round().toString(),
              onChanged: (newValue) {
                setState(() {
                  _sliderValue = newValue;
                });
              },
            ),
          ],
        ),
        const SizedBox(height: 20),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            const Text(
              'Ini Switch',
              style: TextStyle(fontSize: 16),
            ),
            Switch(
              value: _isSwitched,
              onChanged: (value) {
                setState(() {
                  _isSwitched = value;
                });
              },
            ),
          ],
        ),
        const SizedBox(height: 20),

        Text(
          'Nama: $_name',
          style: const TextStyle(fontSize: 16, color: Colors.greenAccent),
        ),
        const SizedBox(height: 8),
        Text(
          'Nilai Slider: ${_sliderValue.round()}',
          style: const TextStyle(fontSize: 16, color: Colors.lightGreen),
        ),
        const SizedBox(height: 8),
        Text(
          'Switch: ${_isSwitched ? 'Aktif' : 'Tidak Aktif'}',
          style: const TextStyle(fontSize: 16, color: Colors.green),
        ),
      ],
    );
  }
}
