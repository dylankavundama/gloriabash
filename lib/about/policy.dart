import 'package:flutter/material.dart';

class policy extends StatefulWidget {
  const policy({super.key});

  @override
  State<policy> createState() => _policyState();
}

class _policyState extends State<policy> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children:  [
            Container(

              color: Color.fromARGB(15, 0, 0, 0),
              child: const Padding(
                padding: EdgeInsets.all(30),
                child: Text(
                "Privacy Policy Introduction Our privacy policy will help you understand what information we collect at GLORIA BASH, how GLORIA BASH uses it, and what choices you have. GLORIA BASH built the GLORIA BASH app as a free app. This SERVICE is provided by GLORIA BASH at no cost and is intended for use as is. If you choose to use our Service, then you agree to the collection and use of information in relation with this policy. The Personal Information that we collect are used for providing and improving the Service. We will not use or share your information with anyone except as described in this Privacy Policy. The terms used in this Privacy Policy have the same meanings as in our Terms and Conditions, which is accessible in our website, unless otherwise defined in this Privacy Policy.\n Information Collection and Use For a better experience while using our Service, we may require you to provide us with certain personally identifiable information, including but not limited to users name, email address, gender, location, pictures. The information that we request will be retained by us and used as described in this privacy policy. The app does use third party services that may collect information used to identify you.\nCookies Cookies are files with small amount of data that is commonly used an anonymous unique identifier. These are sent to your browser from the website that you visit and are stored on your devices’s internal memory.",
                  style: TextStyle(color: Colors.white,fontSize: 16),
                ),
              ),
            ),
            
          ],

          
        ),
      ),
    );
  }
}
