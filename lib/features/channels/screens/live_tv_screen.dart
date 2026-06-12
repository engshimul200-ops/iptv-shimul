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
  String _searchQuery = '';
  String _selectedCountry = 'All';
  String _selectedCategory = 'All';
  List<String> _countries = [];
  List<String> _categories = [];

  @override
  void initState() {
    super.initState();
    _loadChannels();
  }

  _loadChannels() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = Provider.of<ChannelsProvider>(context, listen: false);
      provider.loadChannels();
      _countries = provider.getCountries();
      _categories = provider.getCategories();
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
      body: Column(
        children: [
          // Search Bar
          Padding(
            padding: const EdgeInsets.all(12),
            child: TextField(
              onChanged: (value) {
                setState(() => _searchQuery = value);
                Provider.of<ChannelsProvider>(context, listen: false)
                    .searchChannels(value);
              },
              style: const TextStyle(color: AppTheme.textPrimaryColor),
              decoration: InputDecoration(
                hintText: 'চ্যানেল খুঁজুন...',
                hintStyle: const TextStyle(color: AppTheme.textTertiaryColor),
                prefixIcon:
                    const Icon(Icons.search, color: AppTheme.accentColor),
                suffixIcon: _searchQuery.isNotEmpty
                    ? GestureDetector(
                        onTap: () {
                          setState(() => _searchQuery = '');
                          Provider.of<ChannelsProvider>(context, listen: false)
                              .searchChannels('');
                        },
                        child: const Icon(Icons.clear,
                            color: AppTheme.accentColor),
                      )
                    : null,
                filled: true,
                fillColor: AppTheme.secondaryColor,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
              ),
            ),
          ),

          // Filter Chips
          SizedBox(
            height: 60,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              children: [
                _buildFilterChip(
                  'Country',
                  _countries,
                  _selectedCountry,
                  (value) {
                    setState(() => _selectedCountry = value);
                    Provider.of<ChannelsProvider>(context, listen: false)
                        .filterChannels(_selectedCountry, _selectedCategory);
                  },
                ),
                const SizedBox(width: 12),
                _buildFilterChip(
                  'Category',
                  _categories,
                  _selectedCategory,
                  (value) {
                    setState(() => _selectedCategory = value);
                    Provider.of<ChannelsProvider>(context, listen: false)
                        .filterChannels(_selectedCountry, _selectedCategory);
                  },
                ),
              ],
            ),
          ),

          // Channel Grid
          Expanded(
            child: Consumer<ChannelsProvider>(
              builder: (context, provider, _) {
                if (provider.isLoading) {
                  return const Center(
                    child: CircularProgressIndicator(
                      valueColor:
                          AlwaysStoppedAnimation<Color>(AppTheme.accentColor),
                    ),
                  );
                }

                final channels = _searchQuery.isEmpty
                    ? provider.filteredChannels
                    : provider.channels
                        .where((ch) =>
                            ch['name']
                                .toLowerCase()
                                .contains(_searchQuery.toLowerCase()) ||
                            ch['description']
                                .toLowerCase()
                                .contains(_searchQuery.toLowerCase()))
                        .toList();

                if (channels.isEmpty) {
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
                  itemCount: channels.length,
                  itemBuilder: (context, index) {
                    final channel = channels[index];
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

  Widget _buildFilterChip(String label, List<String> options,
      String selected, Function(String) onSelected) {
    return ActionChip(
      label: Text('$label: $selected'),
      onPressed: () {
        _showFilterDialog(label, options, selected, onSelected);
      },
      backgroundColor: AppTheme.secondaryColor,
      labelStyle: const TextStyle(
        color: AppTheme.textSecondaryColor,
        fontWeight: FontWeight.w500,
      ),
      side: const BorderSide(color: AppTheme.accentColor),
    );
  }

  void _showFilterDialog(String label, List<String> options, String selected,
      Function(String) onSelected) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppTheme.secondaryColor,
        title: Text(
          label,
          style: const TextStyle(color: AppTheme.textPrimaryColor),
        ),
        content: SizedBox(
          width: double.maxFinite,
          child: ListView(
            shrinkWrap: true,
            children: options
                .map((option) => ListTile(
                      title: Text(
                        option,
                        style: TextStyle(
                          color: selected == option
                              ? AppTheme.accentColor
                              : AppTheme.textPrimaryColor,
                          fontWeight: selected == option
                              ? FontWeight.bold
                              : FontWeight.normal,
                        ),
                      ),
                      onTap: () {
                        onSelected(option);
                        Navigator.pop(context);
                      },
                    ))
                .toList(),
          ),
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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          border: Border.all(color: AppTheme.accentColor),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          channel['country'] ?? '',
                          style: const TextStyle(
                            color: AppTheme.accentColor,
                            fontSize: 9,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        channel['name'],
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        channel['description'] ?? '',
                        style: const TextStyle(
                          color: AppTheme.textSecondaryColor,
                          fontSize: 10,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
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
