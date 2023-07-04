import 'package:flutter/material.dart';

class ImageDetailScreen extends StatelessWidget {
  final ImageProvider image;

  const ImageDetailScreen({required this.image});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Image'),
      ),
      body: Center(
        child: Hero(
          tag: image, // Use the same unique tag for the Hero widget
          child: Image(
            image: image,
            fit: BoxFit.contain,

          ),
        ),
      ),
      backgroundColor: Colors.white,
    );
  }
}
