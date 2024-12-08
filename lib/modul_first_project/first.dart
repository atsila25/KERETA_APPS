import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget { //perubahan dinamis dengan setState
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int temp = 0;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: const Color.fromARGB(255, 136, 181, 229),
        appBar: AppBar(
          title: Text('My First Application'),
        ),
        floatingActionButton: FloatingActionButton(onPressed: (){}, child: Icon(Icons.abc),
        ),
        drawer: Drawer(),
        body: Center(
          child: Column(
            children: [
              Text('\nTes Mobile\n'),
              Text(temp.toString()),
              ElevatedButton(onPressed: ()
              {
                setState(()  { //untuk render ulang
                  temp += 1;
                });
                print(temp);
              },
              child: Text('Increment'),
              ),
              ElevatedButton(onPressed: ()
              {
                setState(() {
                  temp -= 1;
                });
                print(temp);
              },
              child: Text('Decrement'),
              ),
              ElevatedButton(onPressed: ()
              {
                print('Tombol di Klik');
              },
              child: Text('Coba Klik'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}