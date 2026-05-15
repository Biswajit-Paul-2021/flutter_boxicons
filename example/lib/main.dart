import 'package:flutter/material.dart';
import 'package:flutter_boxicons_example/box_icons_gallery.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Boxicons Gallery',
      home: Scaffold(
        appBar: AppBar(title: const Text('Boxicons Gallery')),
        body: const BoxiconsGallery(),
      ),
    );
  }
}
