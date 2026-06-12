class AppConstants {
  // App Info
  static const String appName = 'SHIMUL BARAL TV';
  static const String appVersion = '1.0.0';
  static const String developerName = 'SHIMUL BARAL';
  static const String appDescription = 'বিশ্বমানের লাইভ টিভি এবং খেলাধুলা সরাসরি দেখুন';
  
  // Bengali Strings
  static const Map<String, String> bengaliStrings = {
    // Main Navigation
    'home': 'হোম',
    'live_tv': 'লাইভ টিভি',
    'sports': 'খেলাধুলা',
    'news': 'সংবাদ',
    'entertainment': 'বিনোদন',
    'favorites': 'পছন্দের চ্যানেল',
    'schedule': 'সময়সূচী',
    'settings': 'সেটিংস',
    'about': 'আমাদের সম্পর্কে',
    
    // Sports Categories
    'football': 'ফুটবল',
    'cricket': 'ক্রিকেট',
    'tennis': 'টেনিস',
    'basketball': 'বাস্কেটবল',
    'hockey': 'হকি',
    'motorsports': 'মোটরস্পোর্টস',
    'badminton': 'ব্যাডমিন্টন',
    'volleyball': 'ভলিবল',
    'swimming': 'সাঁতার',
    'athletics': 'অ্যাথলেটিক্স',
    'kabaddi': 'কাবাডি',
    'boxing': 'বক্সিং',
    'golf': 'গলফ',
    'racing': 'রেসিং',
    
    // Common Actions
    'search': 'সার্চ করুন',
    'filter': 'ফিল্টার',
    'sort': 'সাজান',
    'watch': 'দেখুন',
    'watch_now': 'এখনই দেখুন',
    'add_favorite': 'পছন্দে যোগ করুন',
    'remove_favorite': 'পছন্দ থেকে বাদ দিন',
    'share': 'শেয়ার করুন',
    'download': 'ডাউনলোড',
    'settings': 'সেটিংস',
    'logout': 'লগআউট',
    'login': 'লগইন',
    'register': 'রেজিস্টার',
    
    // Status & Messages
    'loading': 'লোড হচ্ছে...',
    'no_channels': 'কোন চ্যানেল পাওয়া যায়নি',
    'no_favorites': 'কোন পছন্দের চ্যানেল নেই',
    'no_internet': 'ইন্টারনেট সংযোগ নেই',
    'error': 'ত্রুটি',
    'success': 'সফল',
    'retry': 'আবার চেষ্টা করুন',
    
    // Streaming Quality
    'quality': 'গুণমান',
    'auto': 'স্বয়ংক্রিয়',
    '480p': '480p',
    '720p': '720p',
    '1080p': '1080p',
    
    // Countries
    'bangladesh': 'বাংলাদেশ',
    'india': 'ভারত',
    'pakistan': 'পাকিস্তান',
    'uk': 'যুক্তরাজ্য',
    'usa': 'যুক্তরাষ্ট্র',
    'germany': 'জার্মানি',
    'france': 'ফ্রান্স',
    'spain': 'স্পেইন',
    'italy': 'ইতালি',
    'brazil': 'ব্রাজিল',
    'argentina': 'আর্জেন্টিনা',
    'australia': 'অস্ট্রেলিয়া',
    'japan': 'জাপান',
    'china': 'চীন',
    
    // FIFA World Cup 2026
    'world_cup_2026': 'বিশ্বকাপ ২০২৬',
    'world_cup_live': 'বিশ্বকাপ লাইভ',
    'world_cup_matches': 'বিশ্বকাপ ম্যাচ',
    
    // About
    'developed_by': 'ডেভেলপড এবং পরিচালিত',
    'all_rights_reserved': 'সর্বস্বত্ব সংরক্ষিত',
    'version': 'সংস্করণ',
  };
  
  // API Endpoints
  static const String baseUrl = 'https://api.shimulbaral.tv';
  static const String channelsEndpoint = '/api/channels';
  static const String sportsChannelsEndpoint = '/api/sports-channels';
  static const String scheduleEndpoint = '/api/schedule';
  
  // Firebase Collections
  static const String usersCollection = 'users';
  static const String channelsCollection = 'channels';
  static const String favoritesCollection = 'favorites';
  static const String watchHistoryCollection = 'watch_history';
  static const String notificationsCollection = 'notifications';
  
  // Animation Durations
  static const Duration shortDuration = Duration(milliseconds: 300);
  static const Duration mediumDuration = Duration(milliseconds: 500);
  static const Duration longDuration = Duration(milliseconds: 800);
}