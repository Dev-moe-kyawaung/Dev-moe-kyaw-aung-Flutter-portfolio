import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:google_fonts/google_fonts.dart';
import 'models/portfolio_data.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.phoneUp,
    DeviceOrientation.phoneDown,
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);
  runApp(const MoeKyawAungPortfolio());
}

class MoeKyawAungPortfolio extends StatelessWidget {
  const MoeKyawAungPortfolio({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Moe Kyaw Aung - Senior Android Developer',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
        primaryColor: Color(0xFF7F52FF),
        scaffoldBackgroundColor: Color(0xFFFAFAFA),
        textTheme: GoogleFonts.poppinsTextTheme(
          ThemeData.light().textTheme,
        ),
        colorScheme: ColorScheme.light(
          primary: Color(0xFF7F52FF),
          secondary: Color(0xFF3DDC84),
          surface: Color(0xFFFAFAFA),
        ),
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        primaryColor: Color(0xFF7F52FF),
        scaffoldBackgroundColor: Color(0xFF1A1A2E),
        textTheme: GoogleFonts.poppinsTextTheme(
          ThemeData.dark().textTheme,
        ),
        colorScheme: ColorScheme.dark(
          primary: Color(0xFF7F52FF),
          secondary: Color(0xFF3DDC84),
          surface: Color(0xFF1A1A2E),
        ),
      ),
      themeMode: ThemeMode.system,
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const HomeView(),
    const AppsView(),
    const GitHubView(),
    const SocialView(),
    const ContactView(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (idx) => setState(() => _selectedIndex = idx),
        destinations: [
          NavigationDestination(icon: Icon(Icons.home), label: 'Home'),
          NavigationDestination(icon: Icon(Icons.apps), label: 'Apps'),
          NavigationDestination(icon: Icon(Icons.code), label: 'GitHub'),
          NavigationDestination(icon: Icon(Icons.emoji_people), label: 'Social'),
          NavigationDestination(icon: Icon(Icons.contact_mail), label: 'Contact'),
        ],
      ),
    );
  }
}

// ==================== HOME VIEW ====================
class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final data = PortfolioData.portfolio;
    final stats = data["stats"] as Map<String, dynamic>;

    return SingleChildScrollView(
      child: Column(
        children: [
          // Hero Section
          Container(
            padding: EdgeInsets.all(24),
            child: Column(
              children: [
                // Profile Image
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: CachedNetworkImage(
                    imageUrl: data["profileImage"] as String,
                    width: 150,
                    height: 150,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => CircularProgressIndicator(
                      color: Color(0xFF7F52FF),
                    ),
                    errorWidget: (context, url, error) => Container(
                      width: 150,
                      height: 150,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Icon(Icons.person, size: 80, color: Colors.grey[600]),
                    ),
                  ),
                ),
                SizedBox(height: 16),

                // Name
                Text(
                  data["name"] as String,
                  style: GoogleFonts.poppins(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 8),

                // Title
                Text(
                  data["title"] as String,
                  style: GoogleFonts.poppins(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey[700],
                  ),
                ),
                SizedBox(height: 8),

                // Location
                Text(
                  data["location"] as String,
                  style: GoogleFonts.poppins(fontSize: 16, color: Colors.grey[600]),
                ),
                SizedBox(height: 16),

                // Languages
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: (data["languages"] as List<String>).map((lang) => Chip(
                    label: Text(lang, style: TextStyle(fontSize: 14)),
                    backgroundColor: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                  )).toList(),
                ),
                SizedBox(height: 20),

                // Philosophy
                Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    data["philosophy"] as String,
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),

          // Stats
          Padding(
            padding: EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _StatCard(value: stats["certificates"] as String, label: 'Certificates'),
                _StatCard(value: stats["categories"] as String, label: 'Categories'),
                _StatCard(value: stats["years"] as String, label: 'Years'),
                _StatCard(value: stats["projects"] as String, label: 'Projects'),
              ],
            ),
          ),

          // Currently Building
          Padding(
            padding: EdgeInsets.all(16),
            child: Card(
              color: Theme.of(context).colorScheme.primary,
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Row(
                  children: [
                    Icon(Icons.lightbulb, color: Colors.white, size: 28),
                    SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        data["currentlyBuilding"] as String,
                        style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Tech Stack
          Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '📱 Tech Stack',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 12),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    _SkillChip(name: 'Kotlin', color: Color(0xFF7F52FF)),
                    _SkillChip(name: 'Jetpack', color: Color(0xFF4285F4)),
                    _SkillChip(name: 'MVVM', color: Color(0xFFC9A84C)),
                    _SkillChip(name: 'Flutter', color: Color(0xFF02569B)),
                    _SkillChip(name: 'Dart', color: Color(0xFF02569B)),
                    _SkillChip(name: 'Firebase', color: Color(0xFFFFCA28)),
                    _SkillChip(name: 'Python', color: Color(0xFF3776AB)),
                    _SkillChip(name: 'Git', color: Color(0xFFF05032)),
                  ],
                ),
              ],
            ),
          ),

          // Featured Apps
          Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '🔥 Featured Apps',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 12),
                ...((data["apps"] as List).where((app) => app["featured"] == true).take(4).map((app) =>
                  _AppCard(
                    name: app["name"] as String,
                    icon: app["icon"] as String,
                    url: app["url"] as String,
                    featured: true,
                    isNew: app["new"] == true,
                  )
                )),
              ],
            ),
          ),
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
          style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Color(0xFF7F52FF)),
        ),
        Text(
          label,
          style: TextStyle(fontSize: 14, color: Colors.grey[600]),
        ),
      ],
    );
  }
}

class _SkillChip extends StatelessWidget {
  final String name;
  final Color color;

  const _SkillChip({required this.name, required this.color});

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Text(name, style: TextStyle(fontSize: 14)),
      backgroundColor: color.withOpacity(0.1),
      labelStyle: TextStyle(color: color, fontWeight: FontWeight.w500),
    );
  }
}

class _AppCard extends StatelessWidget {
  final String name;
  final String icon;
  final String url;
  final bool featured;
  final bool isNew;

  const _AppCard({
    required this.name,
    required this.icon,
    required this.url,
    this.featured = false,
    this.isNew = false,
  });

  Future<void> _launchUrl() async {
    final uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: featured ? 8 : 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: _launchUrl,
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: featured 
                    ? Theme.of(context).colorScheme.primary.withOpacity(0.2)
                    : Colors.grey[200],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(child: Text(icon, style: TextStyle(fontSize: 32))),
              ),
              SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (featured || isNew)
                      Row(
                        children: [
                          if (isNew) ...[
                            Icon(Icons.star, color: Colors.orange, size: 16),
                            SizedBox(width: 4),
                            Text('NEW', style: TextStyle(fontSize: 12, color: Colors.orange, fontWeight: FontWeight.bold)),
                          ] else ...[
                            Icon(Icons.star, color: Colors.orange, size: 16),
                            SizedBox(width: 4),
                            Text('FEATURED', style: TextStyle(fontSize: 12, color: Colors.orange, fontWeight: FontWeight.bold)),
                          ],
                        ],
                      ),
                    if (featured || isNew) SizedBox(height: 4),
                    Text(
                      name,
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 4),
                    Row(
                      children: [
                        Icon(Icons.code, size: 16, color: Colors.grey[600]),
                        SizedBox(width: 4),
                        Text('GitHub', style: TextStyle(fontSize: 14, color: Colors.grey[600])),
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

// ==================== APPS VIEW ====================
class AppsView extends StatelessWidget {
  const AppsView({super.key});

  @override
  Widget build(BuildContext context) {
    final apps = (PortfolioData.portfolio["apps"] as List).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('📱 App Collection'),
        centerTitle: true,
      ),
      body: ListView(
        children: apps.map((app) => _AppCard(
          name: app["name"] as String,
          icon: app["icon"] as String,
          url: app["url"] as String,
          featured: app["featured"] == true,
          isNew: app["new"] == true,
        )).toList(),
      ),
    );
  }
}

// ==================== GITHUB VIEW ====================
class GitHubView extends StatelessWidget {
  const GitHubView({super.key});

  @override
  Widget build(BuildContext context) {
    final githubPages = PortfolioData.portfolio["githubPages"] as List<String>;
    final lovableApps = PortfolioData.portfolio["lovableApps"] as List<String>;

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('🐙 GitHub'),
          centerTitle: true,
          bottom: TabBar(
            tabs: [
              Tab(text: 'GitHub Pages (${githubPages.length})'),
              Tab(text: 'Lovable (${lovableApps.length})'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _LinksList(links: githubPages, icon: Icons.web),
            _LinksList(links: lovableApps, icon: Icons.emoji_emotions),
          ],
        ),
      ),
    );
  }
}

class _LinksList extends StatelessWidget {
  final List<String> links;
  final IconData icon;

  const _LinksList({required this.links, required this.icon});

  Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: ListView(
        children: links.map((link) => Card(
          margin: EdgeInsets.symmetric(vertical: 4),
          child: InkWell(
            onTap: () => _launchUrl(link),
            child: Padding(
              padding: EdgeInsets.all(12),
              child: Row(
                children: [
                  Icon(icon, size: 20, color: Colors.grey[600]),
                  SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      link,
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
    );
  }
}

// ==================== SOCIAL VIEW ====================
class SocialView extends StatelessWidget {
  const SocialView({super.key});

  @override
  Widget build(BuildContext context) {
    final socials = PortfolioData.portfolio["socialMedia"] as List;

    return Scaffold(
      appBar: AppBar(
        title: Text('🌐 Social Media'),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: ListView(
          children: socials.map((social) {
            final name = social["name"] as String;
            final url = social["url"] as String;
            final icon = social["icon"] as String;
            final color = Color(social["color"] as String).withOpacity(0.2);

            return FutureBuilder(
              future: Color(social["color"] as String),
              builder: (context, snapshot) => Card(
                margin: EdgeInsets.symmetric(vertical: 6),
                child: InkWell(
                  onTap: () => _launchUrl(url),
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: Row(
                      children: [
                        Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            color: Color(social["color"] as String).withOpacity(0.2),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Center(child: Text(icon, style: TextStyle(fontSize: 28))),
                        ),
                        SizedBox(width: 16),
                        Expanded(
                          child: Text(
                            name,
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Icon(Icons.arrow_forward_ios, size: 20, color: Colors.grey[400]),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw 'Could not launch $url';
    }
  }
}

// ==================== CONTACT VIEW ====================
class ContactView extends StatelessWidget {
  const ContactView({super.key});

  @override
  Widget build(BuildContext context) {
    final data = PortfolioData.portfolio;
    final phones = data["phones"] as List<String>;
    final emails = data["emails"] as List<String>;

    return Scaffold(
      appBar: AppBar(
        title: Text('📬 Contact'),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(24),
        child: Column(
          children: [
            // Phone
            Card(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.phone, color: Theme.of(context).colorScheme.primary),
                        SizedBox(width: 12),
                        Text('Phone', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      ],
                    ),
                    SizedBox(height: 12),
                    ...phones.map((phone) => InkWell(
                      onTap: () => _launchPhone(phone),
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 6),
                        child: Row(
                          children: [
                            Icon(Icons.phone_android, size: 18, color: Colors.grey[600]),
                            SizedBox(width: 12),
                            Text(phone, style: TextStyle(fontSize: 16)),
                          ],
                        ),
                      ),
                    )),
                  ],
                ),
              ),
            ),
            SizedBox(height: 16),

            // Email
            Card(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.email, color: Theme.of(context).colorScheme.primary),
                        SizedBox(width: 12),
                        Text('Email', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      ],
                    ),
                    SizedBox(height: 12),
                    ...emails.map((email) => InkWell(
                      onTap: () => _launchEmail(email),
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 6),
                        child: Row(
                          children: [
                            Icon(Icons.mail, size: 18, color: Colors.grey[600]),
                            SizedBox(width: 12),
                            Text(email, style: TextStyle(fontSize: 16)),
                          ],
                        ),
                      ),
                    )),
                  ],
                ),
              ),
            ),
            SizedBox(height: 24),

            // Location
            Card(
              color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Row(
                  children: [
                    Icon(Icons.location_on, color: Theme.of(context).colorScheme.primary),
                    SizedBox(width: 12),
                    Text(
                      data["location"] as String,
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _launchPhone(String phone) async {
    final uri = Uri.parse('tel:$phone');
    await launchUrl(uri);
  }

  Future<void> _launchEmail(String email) async {
    final uri = Uri.parse('mailto:$email');
    await launchUrl(uri);
  }
}
