import 'package:flutter/material.dart';

class AboutUs extends StatelessWidget {
  const AboutUs({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color.fromARGB(0, 34, 33, 33),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 30),
              child: Text(
                'ABOUT',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(50),
              child: Text(
                """    
Welcome to Vx Player,
Number one mobile phone application that allowsyou to listen
to music files stored in the phone's
internal or external memory""",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
            Text(
              'Vx Player',
              style: TextStyle(
                  color: Color.fromARGB(255, 163, 156, 156), fontSize: 15),
            ),
            Text(
              'version 1.0.0',
              style: TextStyle(
                  color: Color.fromARGB(255, 163, 156, 156), fontSize: 15),
            ),
          ],
        ),
      ),
    );
  }
}
