import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gameon/Mentor/Mentor%20Screen/main_mentor_screen.dart';
import 'package:gameon/Users/views/Screens/auth/signin_screen.dart';
import 'package:gameon/Users/views/Screens/sidebarscreen/about%20us/aboutus.dart';
import 'package:gameon/Users/views/Screens/sidebarscreen/cart/cart.dart';
import 'package:gameon/Users/views/Screens/sidebarscreen/contact%20us/contactus.dart';
import 'package:gameon/Users/views/Screens/sidebarscreen/feedback/feedback.dart';
import 'package:gameon/Users/views/Screens/sidebarscreen/profile/profile.dart';
import 'package:gameon/Users/views/Screens/sidebarscreen/setting/setting.dart';
import 'package:gameon/Users/provider/user_provider.dart'; // import your provider
import 'package:provider/provider.dart';

class Sidebardrawer extends StatelessWidget {
  const Sidebardrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    userProvider.fetchUserData();
    final user = userProvider.userData;

    if (user == null) {
      return const Center(child: CircularProgressIndicator());
    }

    return Drawer(
      child: Material(
        color: const Color(0xFFA32EEB).withOpacity(0.85),
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          children: [
            const SizedBox(height: 50),
            buildHeader(
              name: user['name'] ?? 'User',
              email: user['email'] ?? 'Email',
              imageUrl: user['userimage'],
              onClicked: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Profile()),
                );
              },
            ),
            const SizedBox(height: 20),
            buildSearchField(),
            const Divider(height: 30, color: Colors.white70),
            buildMenuItem(
              icon: Icons.shopping_cart_outlined,
              text: 'Cart',
              onClicked: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const Cart()),
              ),
            ),
            user['mentor'] == true
                ? buildMenuItem(
                    icon: Icons.group_outlined,
                    text: 'Manage as Mentor',
                    onClicked: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => MainMentorScreen()),
                    ),
                  )
                : const SizedBox.shrink(),
            const Divider(height: 30, color: Colors.white70),
            buildMenuItem(
              icon: Icons.contact_mail_outlined,
              text: 'Contact Us',
              onClicked: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const Contactus()),
              ),
            ),
            buildMenuItem(
              icon: Icons.info_outline,
              text: 'About Us',
              onClicked: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => Aboutus()),
              ),
            ),
            buildMenuItem(
              icon: Icons.feedback_outlined,
              text: 'Feedback',
              onClicked: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => Feedbackpage()),
              ),
            ),
            const Divider(height: 30, color: Colors.white70),
            buildMenuItem(
              icon: Icons.settings_outlined,
              text: 'Settings',
              onClicked: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => SettingPage()),
              ),
            ),
            buildMenuItem(
              icon: Icons.logout_outlined,
              text: 'Sign Out',
              onClicked: () async {
                userProvider.clearUserData();
                await FirebaseAuth.instance.signOut();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => SignInScreen()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget buildHeader({
    required String name,
    required String email,
    required String? imageUrl,
    required VoidCallback onClicked,
  }) {
    return InkWell(
      onTap: onClicked,
      child: Row(
        children: [
          CircleAvatar(
            radius: 35,
            backgroundColor: Colors.grey[300],
            backgroundImage: imageUrl != null ? NetworkImage(imageUrl) : null,
            child: imageUrl == null
                ? const Icon(Icons.person, size: 40, color: Colors.white)
                : null,
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  email,
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildSearchField() {
    return TextField(
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        hintText: 'Search...',
        hintStyle: const TextStyle(color: Colors.white54),
        prefixIcon: const Icon(Icons.search, color: Colors.white),
        filled: true,
        fillColor: Colors.white10,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  Widget buildMenuItem({
    required IconData icon,
    required String text,
    VoidCallback? onClicked,
  }) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(vertical: 4),
      leading: Icon(icon, color: Colors.white),
      title: Text(
        text,
        style: const TextStyle(color: Colors.white, fontSize: 16),
      ),
      hoverColor: Colors.white24,
      onTap: onClicked,
    );
  }
}
