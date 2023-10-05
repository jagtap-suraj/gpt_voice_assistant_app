import 'package:flutter/material.dart';
import 'package:gpt_voice_assistant_app/custom_dialog.dart';
import 'package:gpt_voice_assistant_app/home_page.dart';
import 'package:gpt_voice_assistant_app/pallete.dart';
import 'package:url_launcher/url_launcher.dart';

class MenuDrawer extends StatefulWidget {
  const MenuDrawer({super.key});

  @override
  State<MenuDrawer> createState() => _MenuDrawerState();
}

class _MenuDrawerState extends State<MenuDrawer> {
  Future<void> _launchInWebViewOrVC(Uri url) async {
    if (!await launchUrl(url, mode: LaunchMode.inAppWebView)) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Drawer(
      width: size.width * 0.5,
      backgroundColor: Pallete.backgroundColor,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 32, left: 16),
            child: TextButton(
              onPressed: () async {
                _launchInWebViewOrVC(Uri.parse('https://chat.openai.com/auth/login'));
              },
              child: Row(
                children: [
                  Image.asset(
                    'assets/images/chatgpt_logo.png',
                    width: 32,
                    height: 32,
                  ),
                  const SizedBox(width: 16),
                  const Text(
                    'Sign in',
                    style: TextStyle(fontSize: 24, color: Pallete.mainFontColor, fontFamily: 'Cera Pro'),
                  )
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          const Divider(
            color: Pallete.greyColor,
            indent: 16,
            endIndent: 16,
          ),
          const SizedBox(height: 20),
          ListTile(
            leading: const Icon(
              Icons.add,
              color: Pallete.mainFontColor,
            ),
            title: const Text(
              'New Chat',
              style: TextStyle(color: Pallete.mainFontColor, fontFamily: 'Cera Pro'),
            ),
            onTap: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (BuildContext context) => const HomePage(),
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.history,
              color: Pallete.mainFontColor,
            ),
            title: const Text(
              'History',
              style: TextStyle(color: Pallete.mainFontColor, fontFamily: 'Cera Pro'),
            ),
            onTap: () {
              showDialog(
                context: context,
                builder: (context) {
                  return const CustomDialog(message: 'Not available');
                },
              );
            },
          ),
          const SizedBox(height: 10),
          const Divider(
            color: Pallete.greyColor,
            indent: 16,
            endIndent: 16,
          ),
          const SizedBox(height: 10),
          ListTile(
            leading: const Icon(
              Icons.settings_outlined,
              color: Pallete.mainFontColor,
            ),
            title: const Text(
              'Settings',
              style: TextStyle(color: Pallete.mainFontColor, fontFamily: 'Cera Pro'),
            ),
            onTap: () {
              _launchInWebViewOrVC(Uri.parse('https://chat.openai.com/#settings'));
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.help_outline_outlined,
              color: Pallete.mainFontColor,
            ),
            title: const Text(
              'Help Center',
              style: TextStyle(color: Pallete.mainFontColor, fontFamily: 'Cera Pro'),
            ),
            onTap: () {
              _launchInWebViewOrVC(Uri.parse('https://help.openai.com/en/collections/5461535-android-app'));
            },
          ),
        ],
      ),
    );
  }
}
