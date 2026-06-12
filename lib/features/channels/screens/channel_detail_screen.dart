import 'package:flutter/material.dart';

class ChannelDetailScreen extends StatelessWidget {
  final String channelId;

  const ChannelDetailScreen({Key? key, required this.channelId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('চ্যানেল বিস্তারিত'),
      ),
      body: const Center(
        child: Text('চ্যানেল বিস্তারিত পৃষ্ঠা'),
      ),
    );
  }
}
