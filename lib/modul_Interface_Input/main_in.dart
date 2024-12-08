import 'package:flutter/material.dart';
import 'package:prakmob3/modul_Interface_Input/callback_input.dart';
import 'package:prakmob3/modul_Interface_Input/input.dart';
import 'package:prakmob3/modul_Interface_Input/callback.dart';


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
            DropdownWidget(),
            Callback(),
            InputFormWidget() // Memanggil widget dropdown
          ],
        ),
      ),
    ),
  ));
}