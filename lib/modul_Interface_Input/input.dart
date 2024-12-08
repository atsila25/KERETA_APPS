import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    home: Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFieldWidget(), // Memanggil widget input teks
            SizedBox(height: 20), // Menambahkan jarak antara widget
            NumberInputWidget(), // Memanggil widget input angka
            DropdownWidget(), // Memanggil widget dropdown
          ],
        ),
      ),
    ),
  ));
}

// Widget untuk input teks
class TextFieldWidget extends StatelessWidget {
  const TextFieldWidget({Key? key}) : super(key: key); // Tambahkan Key untuk widget

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          TextField(
            decoration: const InputDecoration(
              labelText: 'Masukkan Nama Anda',
              border: OutlineInputBorder(),
            ),
            onChanged: (String text) { // Menambahkan tipe return pada onChanged
              print('Teks yang diinput: $text');
            },
          ),
        ],
      ),
    );
  }
}

// Widget untuk input angka
class NumberInputWidget extends StatelessWidget {
  const NumberInputWidget({Key? key}) : super(key: key); // Tambahkan Key untuk widget

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          TextField(
            keyboardType: TextInputType.number, // Mengubah tipe keyboard ke angka
            decoration: const InputDecoration(
              labelText: 'Masukkan Angka',
              border: OutlineInputBorder(),
            ),
            onChanged: (String text) { // Menambahkan tipe return pada onChanged
              print('Angka yang diinput: $text');
            },
          ),
        ],
      ),
    );
  }
}

// Widget untuk dropdown, diubah menjadi StatefulWidget
class DropdownWidget extends StatefulWidget {
  const DropdownWidget({Key? key}) : super(key: key);

  @override
  _DropdownWidgetState createState() => _DropdownWidgetState();
}

class _DropdownWidgetState extends State<DropdownWidget> {
  final List<String> _options = ['Pilihan 1', 'Pilihan 2', 'Pilihan 3'];
  String _selectedOption = 'Pilihan 1'; // Menyimpan pilihan yang dipilih

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          DropdownButton<String>(
            value: _selectedOption,
            dropdownColor: const Color.fromARGB(255, 0, 0, 0),
            borderRadius: BorderRadius.all(Radius.circular(20)),
            items: _options.map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value,
                style: TextStyle(color: const Color.fromARGB(255, 186, 195, 199)),),
              );
            }).toList(),
            onChanged: (String? newValue) {
              setState(() {
                _selectedOption = newValue!; // Memperbarui pilihan yang dipilih
              });
              print('Pilihan yang dipilih: $_selectedOption');
            },
          ),
        ],
      ),
    );
  }
}
