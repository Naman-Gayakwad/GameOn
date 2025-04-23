import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Contactus extends StatelessWidget {
  const Contactus({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFA32EEB),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back, color: Colors.white),
        ),
        title: const Text('Contact Us', style: TextStyle(color: Colors.white)),
      ),
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromARGB(255, 209, 189, 222),
                  Color.fromARGB(255, 204, 151, 238),
                  Color.fromARGB(255, 198, 147, 229),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: const Text(
                    'How can we help you?',
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                const Text(
                  'Thank you for showing your interest in collaborating and interacting with us. Our hardworking and dedicated team is ready to help you in every possible way.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 20),
                Center(
                  child: Image.asset(
                    'assets/images/drawer/contactusillustration.png',
                    height: 220,
                  ),
                ),
                const SizedBox(height: 24),

                /// Get in Touch Button
                Center(
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFA32EEB),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      padding: const EdgeInsets.symmetric(
                          vertical: 12, horizontal: 24),
                    ),
                    onPressed: () {
                      // You can show a contact form or redirect here
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Get in touch action triggered!"),
                        ),
                      );
                    },
                    icon:  Icon(Icons.mail_outline, color: Colors.white,),
                    label: const Text(
                      'Get in Touch',
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ),
                ),

                const SizedBox(height: 28),
                const Divider(thickness: 1, color: Colors.black26),
                const SizedBox(height: 12),

                const Text(
                  'FAQs',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Our hardworking and dedicated team is eager to help you in every possible way. Explore the FAQs or get in touch for personalized assistance.',
                  style: TextStyle(fontSize: 15),
                ),

                const SizedBox(height: 24),
                const Divider(thickness: 1, color: Colors.black26),
                const SizedBox(height: 12),

                const Text(
                  'Contact Details',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),

                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.white70),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: sendEmail,
                        child: Row(
                          children: const [
                            Icon(Icons.email_outlined, color: Colors.white),
                            SizedBox(width: 8),
                            Text(
                              'gameon@help.com',
                              style: TextStyle(
                                decoration: TextDecoration.underline,
                                fontSize: 18,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 12),
                      GestureDetector(
                        onTap: callNumber,
                        child: Row(
                          children: const [
                            Icon(Icons.phone_outlined, color: Colors.white),
                            SizedBox(width: 8),
                            Text(
                              '+91 2121212121',
                              style: TextStyle(
                                decoration: TextDecoration.underline,
                                fontSize: 18,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 32),
                Center(
                  child: Text(
                    'Thank you for reaching out to GameOn!',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey.shade900,
                    ),
                  ),
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void sendEmail() async {
    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: 'gameon@help.com',
      queryParameters: {'subject': 'Hello', 'body': 'Body of the email'},
    );

    if (await canLaunchUrl(emailLaunchUri)) {
      await launchUrl(emailLaunchUri);
    } else {
      throw 'Could not launch email';
    }
  }

  void callNumber() async {
    final Uri _phoneLaunchUri = Uri(
      scheme: 'tel',
      path: '+91 2121212121',
    );

    if (await canLaunchUrl(_phoneLaunchUri)) {
      await launchUrl(_phoneLaunchUri);
    } else {
      throw 'Could not launch phone';
    }
  }
}
