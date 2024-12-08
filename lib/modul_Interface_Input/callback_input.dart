import 'package:flutter/material.dart';

class InputFormWidget extends StatefulWidget {
  const InputFormWidget({Key? key}) : super(key: key);

  @override
  _InputFormWidgetState createState() => _InputFormWidgetState();
}

class _InputFormWidgetState extends State<InputFormWidget> {
  String _name = '';
  int _age = 0;

  // Key untuk mengelola form validation
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextFormField(
              decoration: const InputDecoration(labelText: 'Nama'),
              onChanged: (text) {
                setState(() {
                  _name = text;
                });
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Nama tidak boleh kosong';
                }
                return null;
              },
            ),
            const SizedBox(height: 10),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Umur'),
              keyboardType: TextInputType.number,
              onChanged: (text) {
                setState(() {
                  _age = int.tryParse(text) ?? 0;
                });
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Umur tidak boleh kosong';
                }
                final age = int.tryParse(value);
                if (age == null || age <= 0) {
                  return 'Masukkan umur yang valid';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  print('Nama: $_name, Umur: $_age');
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Nama: $_name, Umur: $_age')),
                  );
                }
              },
              child: const Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(const MaterialApp(
    home: Scaffold(
      body: Center(
        child: InputFormWidget(),
      ),
    ),
  ));
}
