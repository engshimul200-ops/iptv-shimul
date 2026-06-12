import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/theme/app_theme.dart';
import '../providers/channels_provider.dart';

class LiveTVScreen extends StatefulWidget {
  const LiveTVScreen({Key? key}) : super(key: key);

  @override
  State<LiveTVScreen> createState() => _LiveTVScreenState();
}

class _LiveTVScreenState extends State<LiveTVScreen> {
  @override
  void initState() {
    super.initState();
    _loadChannels();
  }

  _loadChannels() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ChannelsProvider>(context, listen: false).loadChannels();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('লাইভ টিভি'),
        centerTitle: true,
        elevation: 0,
        backgroundColor: AppTheme.secondaryColor,
      ),
      body: Consumer<ChannelsProvider>(
        builder: (context, provider, _) {
          if (provider.isLoading) {
            return const Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(AppTheme.accentColor),
              ),
            );
          }

          if (provider.channels.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.tv_off,
                    size: 60,
                    color: AppTheme.textTertiaryColor,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'কোন চ্যানেল পাওয়া যায়নি',
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
            itemCount: provider.channels.length,
            itemBuilder: (context, index) {
              final channel = provider.channels[index];
              return _buildChannelCard(context, channel);
            },
          );
        },
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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Container(
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
                ),
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Text(
                    channel['name'],
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
