import 'package:flutter/material.dart';

class ChannelsProvider extends ChangeNotifier {
  List<dynamic> _channels = [];
  List<dynamic> _sportsChannels = [];
  bool _isLoading = false;

  List<dynamic> get channels => _channels;
  List<dynamic> get sportsChannels => _sportsChannels;
  bool get isLoading => _isLoading;

  void loadChannels() {
    _isLoading = true;
    notifyListeners();

    _channels = [
      {
        'id': '1',
        'name': 'BTV',
        'logo': 'https://via.placeholder.com/150?text=BTV',
        'streamUrl': 'https://example.com/stream1.m3u8',
        'country': 'Bangladesh',
        'category': 'General',
      },
      {
        'id': '2',
        'name': 'Channel I',
        'logo': 'https://via.placeholder.com/150?text=Channel+I',
        'streamUrl': 'https://example.com/stream2.m3u8',
        'country': 'Bangladesh',
        'category': 'Entertainment',
      },
    ];

    _isLoading = false;
    notifyListeners();
  }

  void loadSportsChannels(String sport) {
    _isLoading = true;
    notifyListeners();

    final Map<String, List<dynamic>> sportsData = {
      'football': [
        {
          'id': 'f1',
          'name': 'ESPN',
          'logo': 'https://via.placeholder.com/150?text=ESPN',
          'streamUrl': 'https://example.com/espn.m3u8',
        },
      ],
      'cricket': [
        {
          'id': 'c1',
          'name': 'Star Sports',
          'logo': 'https://via.placeholder.com/150?text=Star+Sports',
          'streamUrl': 'https://example.com/starsports.m3u8',
        },
      ],
    };

    _sportsChannels = sportsData[sport] ?? [];
    _isLoading = false;
    notifyListeners();
  }
}
