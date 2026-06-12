import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('হোম'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text('হোম পৃষ্ঠা'),
      ),
    );
  }
}
