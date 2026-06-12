import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import '../../../core/theme/app_theme.dart';

class VideoPlayerScreen extends StatefulWidget {
  final String channelName;
  final String streamUrl;
  final String? channelLogo;
  final String? channelId;

  const VideoPlayerScreen({
    Key? key,
    required this.channelName,
    required this.streamUrl,
    this.channelLogo,
    this.channelId,
  }) : super(key: key);

  @override
  State<VideoPlayerScreen> createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  late VideoPlayerController _controller;
  bool _isPlaying = false;
  bool _showControls = true;

  @override
  void initState() {
    super.initState();
    _initializePlayer();
  }

  void _initializePlayer() {
    _controller = VideoPlayerController.networkUrl(
      Uri.parse(widget.streamUrl),
    )..initialize().then((_) {
      setState(() {});
      _controller.play();
      _isPlaying = true;
    }).catchError((error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('ভিডিও লোড করতে ত্রুটি: $error')),
      );
    });

    _controller.addListener(() {
      if (mounted) {
        setState(() {
          _isPlaying = _controller.value.isPlaying;
        });
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(widget.channelName),
        backgroundColor: AppTheme.secondaryColor,
        elevation: 0,
      ),
      body: Center(
        child: _controller.value.isInitialized
            ? GestureDetector(
                onTap: () {
                  setState(() {
                    _showControls = !_showControls;
                  });
                  if (_showControls) {
                    Future.delayed(const Duration(seconds: 3), () {
                      if (mounted) {
                        setState(() {
                          _showControls = false;
                        });
                      }
                    });
                  }
                },
                child: Stack(
                  children: [
                    AspectRatio(
                      aspectRatio: _controller.value.aspectRatio,
                      child: VideoPlayer(_controller),
                    ),
                    if (_showControls)
                      Container(
                        color: Colors.black.withOpacity(0.3),
                      ),
                    if (_showControls)
                      Center(
                        child: FloatingActionButton(
                          backgroundColor: AppTheme.accentColor,
                          onPressed: () {
                            setState(() {
                              _isPlaying
                                  ? _controller.pause()
                                  : _controller.play();
                            });
                          },
                          child: Icon(
                            _isPlaying ? Icons.pause : Icons.play_arrow,
                            size: 32,
                          ),
                        ),
                      ),
                  ],
                ),
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(
                      AppTheme.accentColor,
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'স্ট্রিমিং শুরু হচ্ছে...',
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
      ),
    );
  }
}
