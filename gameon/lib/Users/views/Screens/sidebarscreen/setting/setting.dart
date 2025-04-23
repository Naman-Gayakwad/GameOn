import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gameon/Users/provider/ThemeProvider.dart';
import 'package:gameon/Users/views/Screens/auth/signin_screen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  bool _notificationsEnabled = true;

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _notificationsEnabled = prefs.getBool('notifications') ?? true;
    });
  }

  Future<void> _toggleNotifications(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _notificationsEnabled = value;
    });
    prefs.setBool('notifications', value);
  }

  Future<void> _toggleTheme(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('isDarkMode', value);
    final themeProvider = Provider.of<ThemeProvider>(context, listen: false);
    themeProvider.toggleTheme(value);
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Provider.of<ThemeProvider>(context).isDarkMode;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Settings',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xFFA32EEB),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back, color: Colors.white),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            'General',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),

          // Notification toggle
          SwitchListTile(
            value: _notificationsEnabled,
            onChanged: _toggleNotifications,
            activeColor: const Color(0xFFA32EEB),
            title: const Text('Notifications'),
            subtitle: const Text('Enable or disable app notifications'),
            secondary: const Icon(Icons.notifications_active_outlined),
          ),

          // Theme mode toggle
          SwitchListTile(
            value: isDarkMode,
            onChanged: _toggleTheme,
            activeColor: const Color(0xFFA32EEB),
            title: const Text('Dark Mode'),
            subtitle: const Text('Toggle between light and dark theme'),
            secondary: const Icon(Icons.dark_mode_outlined),
          ),

          const SizedBox(height: 20),
          const Text(
            'More',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),

          // Privacy settings
          ListTile(
            leading: const Icon(Icons.privacy_tip_outlined,
                color: Color(0xFFA32EEB)),
            title: const Text('Privacy Settings'),
            subtitle: const Text('Manage your privacy options'),
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Privacy Settings tapped!")),
              );
            },
          ),

          // Terms & Conditions
          ListTile(
            leading:
                const Icon(Icons.article_outlined, color: Color(0xFFA32EEB)),
            title: const Text('Terms & Conditions'),
            subtitle: const Text('Read our terms and conditions'),
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Terms & Conditions tapped!")),
              );
            },
          ),

          // Help & Support
          ListTile(
            leading: const Icon(Icons.support_agent_outlined,
                color: Color(0xFFA32EEB)),
            title: const Text('Help & Support'),
            subtitle: const Text('Get support or ask for help'),
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Help & Support tapped!")),
              );
            },
          ),

          const Divider(height: 40),

          // App version
          const ListTile(
            leading: Icon(Icons.info_outline, color: Color(0xFFA32EEB)),
            title: Text('App Version'),
            subtitle: Text('1.0.0'),
          ),

          // Logout
          ListTile(
            leading: const Icon(Icons.logout, color: Colors.red),
            title: const Text('Logout'),
            onTap: () async {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Logout tapped!")),
              );
              await FirebaseAuth.instance.signOut();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => SignInScreen()),
              );
            },
          ),
        ],
      ),
    );
  }
}
