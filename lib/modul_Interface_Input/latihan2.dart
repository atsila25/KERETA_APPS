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
          title: const Text('Dropdown Example'),
        ),
        body: const Center(
          child: DropdownDisplayWidget(),
        ),
      ),
    );
  }
}

class DropdownDisplayWidget extends StatefulWidget {
  const DropdownDisplayWidget({Key? key}) : super(key: key);

  @override
  _DropdownDisplayWidgetState createState() => _DropdownDisplayWidgetState();
}

class _DropdownDisplayWidgetState extends State<DropdownDisplayWidget> {
  // Daftar opsi dropdown
  final List<String> _options = ['Teknik Informatika', 'Teknik Sipil', 'Teknik Mesin'];
  String? _selectedOption; // Menyimpan opsi yang dipilih

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // DropdownButton untuk memilih opsi
          DropdownButton<String>(
            value: _selectedOption,
            hint: const Text('Program Studi'),
            items: _options.map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            onChanged: (String? newValue) { // Memperbarui opsi yang dipilih
              setState(() {
                _selectedOption = newValue; 
              });
            },
          ),
          const SizedBox(height: 20), // Jarak antara dropdown dan teks
          
          // Menampilkan opsi yang dipilih
          Text(
            'Program Studi yang dipilih:',
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            _selectedOption ?? 'Belum ada pilihan', // Menampilkan pilihan
            style: const TextStyle(fontSize: 16, color: Colors.blue),
          ),
        ],
      ),
    );
  }
}
