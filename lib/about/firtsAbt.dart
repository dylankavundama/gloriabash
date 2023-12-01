import 'package:flutter/material.dart';
import 'package:gloriabash/about/info.dart';
import 'package:gloriabash/about/policy.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:share/share.dart';

class About extends StatefulWidget {
  const About({super.key});

  @override
  State<About> createState() => _AboutState();
}

class _AboutState extends State<About> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ListTile(
              onTap: () {
                Share.share(
                    'https://play.google.com/store/apps/details?id=com.pcv');
              },
              title: const Text(
                'Share',
                style: TextStyle(color: Colors.white),
              ),
              leading: const Icon(
                Icons.share,
                color: Colors.white,
              ),
              trailing: const Icon(
                Icons.arrow_forward_rounded,
                color: Colors.white,
              ),
            ),
            ListTile(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => info()),
                );
              },
              title: const Text(
                'About',
                style: TextStyle(color: Colors.white),
              ),
              leading: const Icon(
                Icons.info,
                color: Colors.white,
              ),
              trailing: const Icon(
                Icons.arrow_forward_rounded,
                color: Colors.white,
              ),
            ),
            ListTile(
              onTap: () {
                launch(
                    'https://play.google.com/store/apps/details?id=com.easykivu&pcampaignid=web_share');
              },
              title: const Text(
                'Comment',
                style: TextStyle(color: Colors.white),
              ),
              leading: const Icon(
                Icons.add_comment,
                color: Colors.white,
              ),
              trailing: const Icon(
                Icons.arrow_forward,
                color: Colors.white,
              ),
            ),
            ListTile(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => policy()),
                );
              },
              title: const Text(
                'Policy',
                style: TextStyle(color: Colors.white),
              ),
              leading: const Icon(
                Icons.key,
                color: Colors.white,
              ),
              trailing: const Icon(
                Icons.arrow_forward_rounded,
                color: Colors.white,
              ),
            ),
            ListTile(
              onTap: () {
                launch('tel:+243977734735');
              },
              title: const Text(
                'Developper',
                style: TextStyle(color: Colors.white),
              ),
              leading: const Icon(
                Icons.person,
                color: Colors.white,
              ),
              trailing: const Icon(
                Icons.arrow_forward_rounded,
                color: Colors.white,
              ),
            ),
            ListTile(
              onTap: () {
                launch(
                    'https://play.google.com/store/apps/details?id=com.easykivu&pcampaignid=web_share');
              },
              title: const Text(
                'Update',
                style: TextStyle(color: Colors.white),
              ),
              leading: const Icon(
                Icons.update,
                color: Colors.white,
              ),
              trailing: const Icon(
                Icons.arrow_forward,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
      onWillPop: () => _onPressButon(context),
    );
  }
}

Future<bool> _onPressButon(BuildContext context) async {
  bool? ext = await showDialog(
      context: context,
      builder: (BuildContext) {
        return AlertDialog(title: const Text('Exit App'), actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(false);
            },
            child: Text("No"),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(true);
            },
            child: Text("Yes"),
          ),
        ]);
      });

  return ext ?? false;
}
