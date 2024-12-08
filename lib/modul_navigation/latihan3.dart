import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Navigation Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
      routes: {
        '/about': (context) => About(data: 'About page contains a lot of information'),
        '/contact': (context) => Contact(),
      },
    );
  }
}

class HomePage extends StatelessWidget {
  final TextEditingController _titleController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
      ),
      body: Container(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'This is the home page.',
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        About(data: 'About page contains a lot of information'),
                  ),
                );
              },
              child: Text('Go to About'),
            ),
            ElevatedButton(
              onPressed: () {
                // Mengirim argumen saat navigasi ke halaman contact
                Navigator.pushNamed(context, '/contact',
                    arguments: 'Data dikirim dari Home Page');
              },
              child: Text('View Contacts'),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: _titleController,
                decoration: InputDecoration(
                  labelText: 'Masukkan Judul Halaman Baru',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                String title = _titleController.text;
                if (title.isNotEmpty) {
                  // Navigasi dinamis menggunakan MaterialPageRoute
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DynamicPage(title: title),
                    ),
                  );
                } else {
                  // Tampilkan pesan jika input kosong
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Judul tidak boleh kosong!'),
                    ),
                  );
                }
              },
              child: Text('Buat Halaman Dinamis'),
            ),
          ],
        ),
      ),
    );
  }
}

class About extends StatelessWidget {
  final String data;
  About({required this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About This App'),
      ),
      body: Container(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(data),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context); // Kembali ke halaman sebelumnya
              },
              child: Text('Back to Home Page'),
            ),
          ],
        ),
      ),
    );
  }
}

class Contact extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Menangkap argumen yang dikirim dari halaman lain
    final String? contactMessage =
        ModalRoute.of(context)?.settings.arguments as String?;

    return Scaffold(
      appBar: AppBar(
        title: Text('Contact List'),
      ),
      body: Container(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('List Contact anda:'),
            Text(
              contactMessage ??
                  'No data received', // Menampilkan pesan yang dikirim
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context); // Kembali ke halaman sebelumnya
              },
              child: Text('Back to Home Page'),
            ),
          ],
        ),
      ),
    );
  }
}

class DynamicPage extends StatelessWidget {
  final String title;

  DynamicPage({required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Text(
          'Ini adalah halaman dinamis dengan judul: $title',
          style: TextStyle(fontSize: 24),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
