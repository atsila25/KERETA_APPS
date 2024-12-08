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
          title: const Text('Real-time Input'),
        ),
        body: const InputDisplayWidget(),
      ),
    );
  }
}

class InputDisplayWidget extends StatefulWidget {
  const InputDisplayWidget({Key? key}) : super(key: key);

  @override
  _InputDisplayWidgetState createState() => _InputDisplayWidgetState();
}

class _InputDisplayWidgetState extends State<InputDisplayWidget> {
  String _inputText = ''; // Menyimpan input dari TextField

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // TextField untuk mengambil input dari pengguna
          TextField(
            decoration: const InputDecoration(
              labelText: 'Coba ketik sesuatu',
              border: OutlineInputBorder(),
            ),
            onChanged: (text) {
              setState(() {
                _inputText = text; // Memperbarui teks setiap kali diubah
              });
            },
          ),
          const SizedBox(height: 20), // Jarak antara TextField dan Text
          
          // Menampilkan input yang diperbarui secara real-time
          Text(
            'Output dari input yang ada',
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            _inputText, // Menampilkan teks yang diinput
            style: const TextStyle(fontSize: 16, color: Colors.blue),
          ),
        ],
      ),
    );
  }
}
