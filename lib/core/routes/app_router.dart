import 'package:go_router/go_router.dart';
import '../../features/splash/screens/splash_screen.dart';
import '../../features/auth/screens/login_screen.dart';
import '../../features/auth/screens/register_screen.dart';
import '../../features/home/screens/home_screen.dart';
import '../../features/channels/screens/live_tv_screen.dart';
import '../../features/channels/screens/sports_channels_screen.dart';
import '../../features/channels/screens/channel_detail_screen.dart';
import '../../features/favorites/screens/favorites_screen.dart';
import '../../features/search/screens/search_screen.dart';
import '../../features/settings/screens/settings_screen.dart';
import '../../features/about/screens/about_screen.dart';
import '../../features/player/screens/video_player_screen.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: '/',
    routes: [
      // Splash Screen
      GoRoute(
        path: '/',
        builder: (context, state) => const SplashScreen(),
      ),
      
      // Authentication Routes
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: '/register',
        builder: (context, state) => const RegisterScreen(),
      ),
      
      // Main Routes
      GoRoute(
        path: '/home',
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: '/live-tv',
        builder: (context, state) => const LiveTVScreen(),
      ),
      GoRoute(
        path: '/sports',
        builder: (context, state) => const SportChannelsScreen(),
      ),
      GoRoute(
        path: '/channel/:id',
        builder: (context, state) {
          final channelId = state.pathParameters['id']!;
          return ChannelDetailScreen(channelId: channelId);
        },
      ),
      GoRoute(
        path: '/player',
        builder: (context, state) {
          final extra = state.extra as Map<String, dynamic>?;
          return VideoPlayerScreen(
            channelName: extra?['channelName'] ?? 'চ্যানেল',
            streamUrl: extra?['streamUrl'] ?? '',
            channelLogo: extra?['channelLogo'],
            channelId: extra?['channelId'],
          );
        },
      ),
      GoRoute(
        path: '/favorites',
        builder: (context, state) => const FavoritesScreen(),
      ),
      GoRoute(
        path: '/search',
        builder: (context, state) => const SearchScreen(),
      ),
      GoRoute(
        path: '/settings',
        builder: (context, state) => const SettingsScreen(),
      ),
      GoRoute(
        path: '/about',
        builder: (context, state) => const AboutScreen(),
      ),
    ],
    errorBuilder: (context, state) {
      return Scaffold(
        appBar: AppBar(title: const Text('ত্রুটি')),
        body: Center(
          child: Text('পৃষ্ঠা পাওয়া যায়নি: ${state.error}'),
        ),
      );
    },
  );
}