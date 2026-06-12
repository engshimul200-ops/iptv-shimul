import 'package:flutter/material.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('রেজিস্টার'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text('রেজিস্টার পৃষ্ঠা'),
      ),
    );
  }
}
