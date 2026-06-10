import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

// Enable web support
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.phoneUp,
    DeviceOrientation.phoneDown,
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);
  runApp(const MoekyawaungSeniorPortfolio());
}

class MoekyawaungSeniorPortfolio extends StatelessWidget {
  const MoekyawaungSeniorPortfolio({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Moe Kyaw Aung | Senior Android Developer',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
        primaryColor: Color(0xFF7F52FF),
        scaffoldBackgroundColor: Color(0xFFFAFAFA),
        colorScheme: ColorScheme.light(
          primary: Color(0xFF7F52FF),
          secondary: Color(0xFF3DDC84),
          surface: Color(0xFFFAFAFA),
        ),
        textTheme: GoogleFonts.poppinsTextTheme(
          ThemeData.light().textTheme,
        ),
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        primaryColor: Color(0xFF7F52FF),
        scaffoldBackgroundColor: Color(0xFF1A1A2E),
        colorScheme: ColorScheme.dark(
          primary: Color(0xFF7F52FF),
          secondary: Color(0xFF3DDC84),
          surface: Color(0xFF1A1A2E),
        ),
        textTheme: GoogleFonts.poppinsTextTheme(
          ThemeData.dark().textTheme,
        ),
      ),
      themeMode: ThemeMode.system,
      home: const PortfolioHomeScreen(),
    );
  }
}

class PortfolioHomeScreen extends StatefulWidget {
  const PortfolioHomeScreen({super.key});

  @override
  State<PortfolioHomeScreen> createState() => _PortfolioHomeScreenState();
}

class _PortfolioHomeScreenState extends State<PortfolioHomeScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const HomeView(),
    const AppsCollectionScreen(),
    const GitHubCollectionScreen(),
    const LovableAppsScreen(),
    const SocialMediaScreen(),
    const ContactScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (idx) => setState(() => _selectedIndex = idx),
        destinations: [
          NavigationDestination(
            icon: Icon(Icons.home, size: 26),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.apps, size: 26),
            label: 'Apps',
          ),
          NavigationDestination(
            icon: Icon(Icons.code, size: 26),
            label: 'GitHub',
          ),
          NavigationDestination(
            icon: Icon(Icons.emoji_objects, size: 26),
            label: 'Lovable',
          ),
          NavigationDestination(
            icon: Icon(Icons.social_distance, size: 26),
            label: 'Social',
          ),
          NavigationDestination(
            icon: Icon(Icons.contact_mail, size: 26),
            label: 'Contact',
          ),
        ],
      ),
    );
  }
}

// ============================================
// HOME VIEW - Hero Section with Profile
// ============================================
class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          // Hero Section
          Container(
            padding: EdgeInsets.all(24),
            child: Column(
              children: [
                // Profile Image with Gravatar
                ClipRRect(
                  borderRadius: BorderRadius.circular(24),
                  child: Stack(
                    children: [
                      CachedNetworkImage(
                        imageUrl: 'https://res.cloudinary.com/dye5qpwii/image/upload/v1778527878/IMG_20260430_053105_uef0yr.png',
                        width: 160,
                        height: 160,
                        fit: BoxFit.cover,
                        placeholder: (context, url) => CircularProgressIndicator(
                          color: Color(0xFF7F52FF),
                        ),
                        errorWidget: (context, url, error) => Icon(
                          Icons.person,
                          size: 160,
                          color: Colors.grey[400],
                        ),
                      ),
                      // Gravatar Badge
                      Positioned(
                        bottom: 8,
                        right: 8,
                        child: Container(
                          padding: EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: Color(0xFF7F52FF),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: Colors.white, width: 2),
                          ),
                          child: Icon(Icons.star, size: 16, color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),

                // Name with Typing Animation
                AnimatedTextKit(
                  animatedTexts: [
                    TypewriterAnimatedText(
                      'မိုးကျော်အောင် · Moe Kyaw Aung',
                      textStyle: GoogleFonts.poppins(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF7F52FF),
                      ),
                      speed: Duration(milliseconds: 50),
                    ),
                  ],
                  isRepeatingAnimation: false,
                ),
                SizedBox(height: 8),

                // Title
                Text(
                  'Senior Android Developer',
                  style: GoogleFonts.poppins(
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey[700],
                  ),
                ),
                SizedBox(height: 8),

                // Location
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.location_on, size: 18, color: Colors.grey[600]),
                    SizedBox(width: 4),
                    Text(
                      'Tachileik, Myanmar 🇲🇲  ↔  Bangkok, Thailand 🇹🇭',
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16),

                // Languages
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  alignment: WrapAlignment.center,
                  children: [
                    Chip(
                      label: Text('Burmese 🇲🇲'),
                      backgroundColor: Color(0xFF7F52FF).withOpacity(0.1),
                    ),
                    Chip(
                      label: Text('English 🌐'),
                      backgroundColor: Color(0xFF7F52FF).withOpacity(0.1),
                    ),
                    Chip(
                      label: Text('Kotlin ☕'),
                      backgroundColor: Color(0xFF7F52FF).withOpacity(0.1),
                    ),
                  ],
                ),
                SizedBox(height: 24),

                // Philosophy Card
                Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Color(0xFF7F52FF).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: Color(0xFF7F52FF).withOpacity(0.3),
                      width: 1,
                    ),
                  ),
                  child: Column(
                    children: [
                      Icon(Icons.lightbulb_outline, 
                        size: 40, 
                        color: Color(0xFF7F52FF)
                      ),
                      SizedBox(height: 12),
                      Text(
                        'Code with culture. Build with purpose.',
                        style: GoogleFonts.poppins(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF7F52FF),
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Stats Section
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _StatCard(value: '82+', label: 'Certificates'),
                _StatCard(value: '9', label: 'Categories'),
                _StatCard(value: '3+', label: 'Years'),
                _StatCard(value: '40+', label: 'Projects'),
              ],
            ),
          ),
          SizedBox(height: 24),

          // Tech Stack Section
          Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.memory, color: Color(0xFF7F52FF)),
                    SizedBox(width: 8),
                    Text(
                      '📱 Tech Stack',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16),
                
                // Android Section
                _TechSection(
                  title: '🏗️ Android / Mobile',
                  skills: ['Kotlin', 'Jetpack Compose', 'Android', 'MVVM', 'Clean Arch'],
                ),
                SizedBox(height: 12),
                
                // Backend Section
                _TechSection(
                  title: '☁️ Backend & Cloud',
                  skills: ['Firebase', 'REST APIs', 'Python', 'Retrofit', 'Room'],
                ),
                SizedBox(height: 12),
                
                // AI/ML Section
                _TechSection(
                  title: '🤖 AI / ML',
                  skills: ['Claude API', 'TFLite', 'On-Device ML'],
                ),
                SizedBox(height: 12),
                
                // Dev Tools Section
                _TechSection(
                  title: '🛠️ Dev Tools',
                  skills: ['Git', 'GitHub Actions', 'VS Code', 'Figma'],
                ),
              ],
            ),
          ),

          // Currently Building
          Padding(
            padding: EdgeInsets.all(16),
            child: Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Color(0xFF7F52FF),
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Color(0xFF7F52FF).withOpacity(0.3),
                    blurRadius: 8,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Icon(Icons.lightbulb, color: Colors.white, size: 32),
                  SizedBox(width: 16),
                  Expanded(
                    child: Text(
                      'Currently Building:
MoekyawTranslator — AI Translation App',
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 24),

          // Professional Summary
          Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.badge, color: Color(0xFF7F52FF)),
                    SizedBox(width: 8),
                    Text(
                      '📋 Professional Summary',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16),
                Card(
                  child: Padding(
                    padding: EdgeInsets.all(20),
                    child: Text(
                      'Senior Android Engineer with strong experience designing and delivering high-performance mobile applications using Kotlin, Jetpack, MVVM/MVI, and Clean Architecture. Proven expertise integrating Firebase (Auth, Firestore, Cloud Messaging, Crashlytics) and RESTful APIs. Experienced in setting up CI/CD pipelines using GitHub Actions and Azure DevOps. Passionate about writing clean, testable code and mentoring junior developers.',
                      style: GoogleFonts.poppins(
                        fontSize: 15,
                        color: Colors.grey[700],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 24),

          // Featured Projects
          Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.star, color: Colors.orange, size: 24),
                    SizedBox(width: 8),
                    Text(
                      '🔥 Featured Projects',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16),
                _FeaturedProjectCard(
                  name: 'Social Dashboard',
                  icon: '📱',
                  description: 'New - Advanced social media dashboard with real-time analytics',
                  githubUrl: 'https://github.com/moekyawaung-tech/social-dashboard',
                ),
                SizedBox(height: 12),
                _FeaturedProjectCard(
                  name: 'Video Player',
                  icon: '🎯',
                  description: 'Custom video player with advanced playback controls',
                  githubUrl: 'https://github.com/moekyawaung-tech/video-player',
                ),
                SizedBox(height: 12),
                _FeaturedProjectCard(
                  name: 'LEGEND!',
                  icon: '🎯',
                  description: 'Ultimate project showcasing senior-level architecture',
                  githubUrl: 'https://github.com/moekyawaung-tech',
                ),
              ],
            ),
          ),
          SizedBox(height: 16),
        ],
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String value;
  final String label;

  const _StatCard({required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: Color(0xFF7F52FF),
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }
}

class _TechSection extends StatelessWidget {
  final String title;
  final List<String> skills;

  const _TechSection({required this.title, required this.skills});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.grey[700],
          ),
        ),
        SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: skills.map((skill) => Chip(
            label: Text(skill, style: TextStyle(fontSize: 14)),
            backgroundColor: Color(0xFF7F52FF).withOpacity(0.1),
            labelStyle: TextStyle(color: Color(0xFF7F52FF)),
          )).toList(),
        ),
      ],
    );
  }
}

class _FeaturedProjectCard extends StatelessWidget {
  final String name;
  final String icon;
  final String description;
  final String githubUrl;

  const _FeaturedProjectCard({
    required this.name,
    required this.icon,
    required this.description,
    required this.githubUrl,
  });

  Future<void> _launchUrl() async {
    final uri = Uri.parse(githubUrl);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw 'Could not launch $githubUrl';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        onTap: _launchUrl,
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                width: 70,
                height: 70,
                decoration: BoxDecoration(
                  color: Color(0xFF7F52FF).withOpacity(0.2),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Center(child: Text(icon, style: TextStyle(fontSize: 36))),
              ),
              SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          name,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(width: 8),
                        Icon(Icons.star, color: Colors.orange, size: 18),
                      ],
                    ),
                    SizedBox(height: 4),
                    Text(
                      description,
                      style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                    ),
                    SizedBox(height: 8),
                    Row(
                      children: [
                        Icon(Icons.code, size: 16, color: Colors.grey[500]),
                        SizedBox(width: 4),
                        Text('GitHub', style: TextStyle(fontSize: 14, color: Colors.grey[500])),
                      ],
                    ),
                  ],
                ),
              ),
              Icon(Icons.arrow_forward_ios, size: 20, color: Colors.grey[400]),
            ],
          ),
        ),
      ),
    );
  }
}

// ============================================
// APPS COLLECTION SCREEN
// ============================================
class AppsCollectionScreen extends StatelessWidget {
  const AppsCollectionScreen({super.key});

  final List<Map<String, String>> _apps = [
    {'icon': '📱', 'name': 'Social Dashboard', 'url': 'https://github.com/moekyawaung-tech/social-dashboard', 'featured': 'true'},
    {'icon': '📱', 'name': 'PWA App', 'url': 'https://github.com/moekyawaung-tech/pwa-app'},
    {'icon': '📊', 'name': 'Admin Dashboard', 'url': 'https://github.com/moekyawaung-tech'},
    {'icon': '📈', 'name': 'Stock Market', 'url': 'https://github.com/moekyawaung-tech'},
    {'icon': '🎮', 'name': 'Game Collection', 'url': 'https://github.com/moekyawaung-tech/game-collection'},
    {'icon': '🎵', 'name': 'Music Player', 'url': 'https://github.com/moekyawaung-tech'},
    {'icon': '💬', 'name': 'Chat App', 'url': 'https://github.com/moekyawaung-tech'},
    {'icon': '⚽', 'name': 'World Cup', 'url': 'https://github.com/moekyawaung-tech'},
    {'icon': '🛒', 'name': 'E-commerce', 'url': 'https://github.com/moekyawaung-tech'},
    {'icon': '💼', 'name': 'Portfolio', 'url': 'https://github.com/moekyawaung-tech'},
    {'icon': '💰', 'name': 'Money Tracker', 'url': 'https://github.com/moekyawaung-tech'},
    {'icon': '🌤️', 'name': 'Weather', 'url': 'https://github.com/moekyawaung-tech/Weather-app'},
    {'icon': '💸', 'name': 'Crypto', 'url': 'https://github.com/moekyawaung-tech'},
    {'icon': '📝', 'name': 'Todo', 'url': 'https://github.com/moekyawaung-tech/javascript-todo'},
    {'icon': '🎯', 'name': 'Video Player', 'url': 'https://github.com/moekyawaung-tech/video-player', 'featured': 'true'},
    {'icon': '🎯', 'name': 'LEGEND!', 'url': 'https://github.com/moekyawaung-tech', 'featured': 'true'},
  ];

  Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('📱 App Collection'),
        centerTitle: true,
        elevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            // Header
            Card(
              color: Color(0xFF7F52FF).withOpacity(0.1),
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Row(
                  children: [
                    Icon(Icons.apps, color: Color(0xFF7F52FF), size: 32),
                    SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${_apps.length} Senior-Level Apps',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF7F52FF),
                            ),
                          ),
                          Text(
                            'Production-ready mobile & web applications',
                            style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 16),

            // App List
            Expanded(
              child: ListView(
                children: _apps.map((app) => Card(
                  margin: EdgeInsets.symmetric(vertical: 6),
                  elevation: app['featured'] == 'true' ? 6 : 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                    side: app['featured'] == 'true' 
                      ? BorderSide(color: Color(0xFF7F52FF), width: 2)
                      : BorderSide.none,
                  ),
                  child: InkWell(
                    onTap: () => _launchUrl(app['url']!),
                    child: Padding(
                      padding: EdgeInsets.all(16),
                      child: Row(
                        children: [
                          Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              color: app['featured'] == 'true'
                                ? Color(0xFF7F52FF).withOpacity(0.2)
                                : Colors.grey[200],
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Center(child: Text(app['icon']!, style: TextStyle(fontSize: 32))),
                          ),
                          SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                if (app['featured'] == 'true')
                                  Row(
                                    children: [
                                      Icon(Icons.star, color: Colors.orange, size: 14),
                                      SizedBox(width: 4),
                                      Text(
                                        'FEATURED',
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.orange,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                Text(
                                  app['name']!,
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 4),
                                Row(
                                  children: [
                                    Icon(Icons.code, size: 14, color: Colors.grey[500]),
                                    SizedBox(width: 4),
                                    Text(
                                      'GitHub',
                                      style: TextStyle(fontSize: 13, color: Colors.grey[500]),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Icon(Icons.arrow_forward_ios, size: 18, color: Colors.grey[400]),
                        ],
                      ),
                    ),
                  ),
                )).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ============================================
// GITHUB COLLECTION SCREEN
// ============================================
class GitHubCollectionScreen extends StatelessWidget {
  const GitHubCollectionScreen({super.key});

  final List<String> _githubSites = [
    'https://moekyawaung-china.github.io/',
    'https://moekyawaung-developer.github.io/',
    'https://moekyawaungvivov30pro-design.github.io/',
    'https://moekyaw-aung-mm.github.io/',
    'https://moekyawaung-mk.github.io/',
    'https://moekyawaung-microsoft.github.io/',
    'https://moekyawaung-cyber.github.io/',
    'https://moekyawaung-bangkok.github.io/',
    'https://moekyawaung-micro.github.io/',
    'https://moekyawaung.github.io/',
    'https://Moekyawaung-mm.github.io/',
    'https://moekyawaung-tech.github.io/',
    'https://moekyawaung-hack.github.io/',
    'https://moekyawaung-graduate.github.io/',
    'https://Moekyawaung-Linux.github.io/',
    'https://Moekyawaung-coder.github.io/',
    'https://moekyawaung-web.github.io/',
    'https://Moekyawaung-dev.github.io/',
    'https://MoeKyawAung-code.github.io/',
    'https://moekyawaung-creator.github.io/',
    'https://moekyawaung-webdeveloper.github.io/',
    'https://Moekyawaung-co.github.io/',
    'https://moekyawaung-edu.github.io/',
    'https://moekyawaung-senior.github.io/',
    'https://Moekyawaung-Development.github.io/',
    'https://moekyawaung-google.github.io/',
    'https://Moe-KyawAung.github.io/',
  ];

  Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🐙 GitHub Collections'),
        centerTitle: true,
        elevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            // Header
            Card(
              color: Color(0xFF2088FF).withOpacity(0.1),
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Row(
                  children: [
                    Icon(Icons.code, color: Color(0xFF2088FF), size: 32),
                    SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${_githubSites.length} GitHub Pages',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF2088FF),
                            ),
                          ),
                          Text(
                            'Deployed across multiple accounts',
                            style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 16),

            // GitHub Sites List
            Expanded(
              child: ListView(
                children: _githubSites.map((site) => Card(
                  margin: EdgeInsets.symmetric(vertical: 4),
                  child: InkWell(
                    onTap: () => _launchUrl(site),
                    child: Padding(
                      padding: EdgeInsets.all(14),
                      child: Row(
                        children: [
                          Icon(Icons.web, size: 22, color: Colors.grey[600]),
                          SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              site,
                              style: TextStyle(fontSize: 14, height: 1.4),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey[400]),
                        ],
                      ),
                    ),
                  ),
                )).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ============================================
// LOVABLE APPS SCREEN
// ============================================
class LovableAppsScreen extends StatelessWidget {
  const LovableAppsScreen({super.key});

  final List<String> _lovableApps = [
    'https://happy-cv-creator.lovable.app',
    'https://moekyawaung.lovable.app',
    'https://moekyawaungmybio.lovable.app/',
    'https://the-cv-palette.lovable.app',
    'https://moekyaw-url.lovable.app',
    'https://moekyawaung-dev.lovable.app',
    'https://moe-kyaw-aung.lovable.app',
    'https://moekyawaungmka.lovable.app',
    'https://moekyaw.lovable.app',
    'https://m-moekyaw.lovable.app',
    'https://dev-moekyawaung.lovable.app',
    'https://cv-beacon.lovable.app/',
    'https://moekyawaungmkamka.lovable.app',
    'https://pixel-perfect-snap-39.lovable.app',
    'https://devmoekyaw.lovable.app',
    'https://profile-persuasion-hub.lovable.app',
    'https://moekyawaung-github.lovable.app',
    'https://moekyawgithub.lovable.app',
    'https://mmoekyaw.lovable.app',
    'https://color-code-chronicles.lovable.app',
  ];

  Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🎨 Lovable Apps'),
        centerTitle: true,
        elevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            // Header
            Card(
              color: Color(0xFFFF6B6B).withOpacity(0.1),
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Row(
                  children: [
                    Icon(Icons.emoji_objects, color: Color(0xFFFF6B6B), size: 32),
                    SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${_lovableApps.length} Lovable Projects',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFFFF6B6B),
                            ),
                          ),
                          Text(
                            'Web apps & portfolios on Lovable',
                            style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 16),

            // Lovable Apps List
            Expanded(
              child: ListView(
                children: _lovableApps.map((app) => Card(
                  margin: EdgeInsets.symmetric(vertical: 4),
                  child: InkWell(
                    onTap: () => _launchUrl(app),
                    child: Padding(
                      padding: EdgeInsets.all(14),
                      child: Row(
                        children: [
                          Icon(Icons.web, size: 22, color: Colors.grey[600]),
                          SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              app,
                              style: TextStyle(fontSize: 14),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey[400]),
                        ],
                      ),
                    ),
                  ),
                )).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ============================================
// SOCIAL MEDIA SCREEN
// ============================================
class SocialMediaScreen extends StatelessWidget {
  const SocialMediaScreen({super.key});

  final List<Map<String, String>> _socials = [
    {'name': 'GitHub', 'url': 'https://github.com/Dev-moe-kyawaung', 'icon': '🐙', 'color': '#24292'},
    {'name': 'Gravatar', 'url': 'https://gravatar.com/moekyawaung2026', 'icon': '🎨', 'color': '#7F52FF'},
    {'name': 'LinkedIn', 'url': 'https://www.linkedin.com/in/moe-kyaw-aung-2653093a1', 'icon': '💼', 'color': '#0A66C2'},
    {'name': 'YouTube', 'url': 'https://www.youtube.com/channel/UCuTXUguZb4xjeL2nX8WJG', 'icon': '📺', 'color': '#FF0000'},
    {'name': 'Tumblr', 'url': 'https://www.tumblr.com/moekyawaung', 'icon': '📝', 'color': '#36465D'},
    {'name': 'Flickr', 'url': 'https://www.flickr.com/people/204037451@N06', 'icon': '📷', 'color': '#0063D2'},
    {'name': 'Bluesky', 'url': 'https://bsky.app/profile/moekyawaung96.bsky.social', 'icon': '🌐', 'color': '#1185FE'},
    {'name': 'Vimeo', 'url': 'https://vimeo.com/user252414232', 'icon': '🎬', 'color': '#1AB7EA'},
    {'name': 'Slack', 'url': 'https://moekyawaung.slack.com/', 'icon': '💬', 'color': '#4A154B'},
    {'name': 'PayPal', 'url': 'https://www.paypal.com/paypalme/my/profile', 'icon': '💳', 'color': '#003087'},
    {'name': 'Strikingly', 'url': 'http://moekyawaung2026.strikingly.com', 'icon': '🌐', 'color': '#2C2C2C'},
  ];

  Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🌐 Social Media'),
        centerTitle: true,
        elevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            // Gravatar Card
            Card(
              color: Color(0xFF7F52FF).withOpacity(0.1),
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: CachedNetworkImage(
                        imageUrl: 'https://res.cloudinary.com/dye5qpwii/image/upload/v1778763535/MKA_25_lbx6fb.webp',
                        width: 60,
                        height: 60,
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'My Gravatar Profile',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF7F52FF),
                            ),
                          ),
                          Text(
                            'Global profile with 16+ social links',
                            style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.arrow_forward_ios, color: Color(0xFF7F52FF)),
                      onPressed: () => _launchUrl('https://gravatar.com/moekyawaung2026'),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 16),

            // Social Media Grid
            Expanded(
              child: ListView(
                children: _socials.map((social) => Card(
                  margin: EdgeInsets.symmetric(vertical: 6),
                  child: InkWell(
                    onTap: () => _launchUrl(social['url']!),
                    child: Padding(
                      padding: EdgeInsets.all(16),
                      child: Row(
                        children: [
                          Container(
                            width: 55,
                            height: 55,
                            decoration: BoxDecoration(
                              color: Color(int.parse(social['color']!), opacity: 0.1),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Center(child: Text(social['icon']!, style: TextStyle(fontSize: 28))),
                          ),
                          SizedBox(width: 16),
                          Expanded(
                            child: Text(
                              social['name']!,
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Icon(Icons.arrow_forward_ios, size: 18, color: Colors.grey[400]),
                        ],
                      ),
                    ),
                  ),
                )).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ============================================
// CONTACT SCREEN
// ============================================
class ContactScreen extends StatelessWidget {
  const ContactScreen({super.key});

  final List<String> _phones = ['+95 9 889 000 889', '+959 666 000 050'];
  final List<String> _emails = [
    'moekyawaung@programmer.net',
    'moekyawaung@technologist.com',
    'moekyawaung@engineer.com',
    'moekyawaung@collector.org',
    'moekyawaung@techie.com',
  ];

  Future<void> _launchPhone(String phone) async {
    final uri = Uri.parse('tel:$phone');
    await launchUrl(uri);
  }

  Future<void> _launchEmail(String email) async {
    final uri = Uri.parse('mailto:$email');
    await launchUrl(uri);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('📬 Contact'),
        centerTitle: true,
        elevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.all(24),
        child: Column(
          children: [
            // Profile Card
            Card(
              color: Color(0xFF7F52FF).withOpacity(0.1),
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: CachedNetworkImage(
                        imageUrl: 'https://res.cloudinary.com/dye5qpwii/image/upload/v1778527878/IMG_20260430_053105_uef0yr.png',
                        width: 80,
                        height: 80,
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(width: 20),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Moe Kyaw Aung',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF7F52FF),
                            ),
                          ),
                          Text(
                            'Senior Android Developer',
                            style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                          ),
                          SizedBox(height: 8),
                          Row(
                            children: [
                              Icon(Icons.location_on, size: 16, color: Colors.grey[500]),
                              SizedBox(width: 4),
                              Text(
                                'Tachileik, Myanmar 🇲🇲',
                                style: TextStyle(fontSize: 14),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 24),

            // Phone Section
            Card(
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.phone, color: Color(0xFF7F52FF), size: 24),
                        SizedBox(width: 12),
                        Text(
                          'Phone',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                    ..._phones.map((phone) => InkWell(
                      onTap: () => _launchPhone(phone),
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        child: Row(
                          children: [
                            Icon(Icons.phone_android, size: 20, color: Colors.grey[600]),
                            SizedBox(width: 12),
                            Text(phone, style: TextStyle(fontSize: 17)),
                            SizedBox(width: 8),
                            Icon(Icons.call, size: 18, color: Color(0xFF7F52FF)),
                          ],
                        ),
                      ),
                    )),
                  ],
                ),
              ),
            ),
            SizedBox(height: 16),

            // Email Section
            Card(
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.email, color: Color(0xFF7F52FF), size: 24),
                        SizedBox(width: 12),
                        Text(
                          'Email',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                    ..._emails.map((email) => InkWell(
                      onTap: () => _launchEmail(email),
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        child: Row(
                          children: [
                            Icon(Icons.mail, size: 20, color: Colors.grey[600]),
                            SizedBox(width: 12),
                            Expanded(
                              child: Text(email, style: TextStyle(fontSize: 16)),
                            ),
                            Icon(Icons.email, size: 18, color: Color(0xFF7F52FF)),
                          ],
                        ),
                      ),
                    )),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
