import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/theme/app_theme.dart';
import '../providers/channels_provider.dart';

class SportChannelsScreen extends StatefulWidget {
  const SportChannelsScreen({Key? key}) : super(key: key);

  @override
  State<SportChannelsScreen> createState() => _SportChannelsScreenState();
}

class _SportChannelsScreenState extends State<SportChannelsScreen> {
  String selectedSport = 'football';
  final List<String> sports = [
    'football',
    'cricket',
    'tennis',
    'basketball',
    'hockey',
    'motorsports',
  ];

  @override
  void initState() {
    super.initState();
    _loadSportsChannels();
  }

  _loadSportsChannels() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ChannelsProvider>(context, listen: false)
          .loadSportsChannels(selectedSport);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('খেলাধুলা'),
        centerTitle: true,
        elevation: 0,
        backgroundColor: AppTheme.secondaryColor,
      ),
      body: Column(
        children: [
          SizedBox(
            height: 60,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.all(12),
              children: sports
                  .map((sport) => _buildSportChip(sport))
                  .toList(),
            ),
          ),
          Expanded(
            child: Consumer<ChannelsProvider>(
              builder: (context, provider, _) {
                if (provider.isLoading) {
                  return const Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                        AppTheme.accentColor,
                      ),
                    ),
                  );
                }

                if (provider.sportsChannels.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.sports_soccer,
                          size: 60,
                          color: AppTheme.textTertiaryColor,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'এই বিভাগে চ্যানেল পাওয়া যায়নি',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ],
                    ),
                  );
                }

                return GridView.builder(
                  padding: const EdgeInsets.all(12),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.75,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                  ),
                  itemCount: provider.sportsChannels.length,
                  itemBuilder: (context, index) {
                    final channel = provider.sportsChannels[index];
                    return _buildChannelCard(context, channel);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSportChip(String sport) {
    final sportNames = {
      'football': '⚽ ফুটবল',
      'cricket': '🏏 ক্রিকেট',
      'tennis': '🎾 টেনিস',
      'basketball': '🏀 বাস্কেটবল',
      'hockey': '🏑 হকি',
      'motorsports': '🏎️ মোটরস্পোর্টস',
    };

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6),
      child: FilterChip(
        label: Text(sportNames[sport] ?? sport),
        selected: selectedSport == sport,
        onSelected: (selected) {
          if (selected) {
            setState(() {
              selectedSport = sport;
            });
            _loadSportsChannels();
          }
        },
        backgroundColor: AppTheme.secondaryColor,
        selectedColor: AppTheme.accentColor,
        labelStyle: TextStyle(
          color: selectedSport == sport
              ? Colors.white
              : AppTheme.textSecondaryColor,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildChannelCard(BuildContext context, dynamic channel) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          '/player',
          arguments: {
            'channelName': channel['name'],
            'streamUrl': channel['streamUrl'],
            'channelLogo': channel['logo'],
          },
        );
      },
      child: Card(
        child: Container(
          decoration: BoxDecoration(
            color: AppTheme.secondaryColor,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              gradient: LinearGradient(
                colors: [
                  Colors.black.withOpacity(0.3),
                  Colors.black.withOpacity(0.8),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: AppTheme.accentColor,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: const Text(
                      'লাইভ',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    channel['name'],
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
