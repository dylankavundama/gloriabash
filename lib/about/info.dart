import 'package:flutter/material.dart';

class info extends StatefulWidget {
  const info({super.key});

  @override
  State<info> createState() => _infoState();
}

class _infoState extends State<info> {
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
                  "This application was developed by D-Corp in partnership with Devactu, both based in DRC/NK/GOMA.This app is intended for the young and talented musician 'GLORIA BASH' who is today one of the best Congolese and Gomatracien artists, we are eager to receive your suggestions for the improvement of this last.leave your comments on Playstore to allow us to make updates. Thank you.\n\n ",
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
