import 'package:flutter/material.dart';
import 'package:gloriabash/homepage.dart';

class navBar extends StatefulWidget {
  const navBar({super.key});

  @override
  State<navBar> createState() => _navBarState();
}

class _navBarState extends State<navBar> {
  int currentindex = 0;
  List<Widget> screen = [
    const ScreenWelcome(),
    ScreenWelcome(),
    const ScreenWelcome(),
    const ScreenWelcome()
  ];
  void _listbotton(int index) {
    currentindex = index;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(),
      bottomSheet: screen[currentindex],
      bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: currentindex,
          selectedItemColor: Colors.white,
          onTap: (index) {
            setState(() {
              currentindex = index;
            });
          },
          items: const [
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.house_outlined,
                  size: 19,
                  color: Colors.white,
                ),
                label: 'Acceuil',
                backgroundColor: Colors.white),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.sports_soccer_outlined,
                  size: 19,
                  color: Colors.white,
                ),
                label: 'Matches',
                backgroundColor: Colors.white),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.movie_outlined,
                  size: 19,
                  color: Colors.white,
                ),
                label: 'Videos',
                backgroundColor: Colors.white),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.people_rounded,
                  size: 19,
                  color: Colors.white,
                ),
                label: 'Joueurs',
                backgroundColor: Colors.white),
          ]),
    );
  }
}
