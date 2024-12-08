import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ImageDisplayScreen extends StatefulWidget {
  @override
  State<ImageDisplayScreen> createState() => _ImageDisplayScreenState();
}

class _ImageDisplayScreenState extends State<ImageDisplayScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Network Image Example'),
      ),
      body: Center(
        child: Container(
          width: 300, // Atur lebar sesuai kebutuhan
          height: 400, // Atur tinggi sesuai kebutuhan
          child: CachedNetworkImage(
            imageUrl: 'https://m.media-amazon.com/images/I/71P3B7R0dtL.jpg', 
            // Ganti URL dengan URL gambar yang diinginkan
            fit: BoxFit.cover, // Mengatur bagaimana gambar diisi dalam container
            placeholder: (context, url) => CircularProgressIndicator(),
            errorWidget: (context, url, error) => Icon(Icons.error),
          ),
        ),
      ),
    );
  }
}
