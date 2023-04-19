import 'package:audio_player_final/screens/search.dart';
import 'package:audio_player_final/screens/allsongs.dart';
import 'package:flutter/material.dart';

import 'package:audio_player_final/screens/librory.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final pages = [const AllSongs(), const SearchSCreen(), const Library()];
  int selecteIndex = 0;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (selecteIndex == 0) {
          return true;
        }
        setState(() {
          selecteIndex = 0;
        });
        return false;
      },
      child: Scaffold(
          body: Container(child: pages[selecteIndex]),
          bottomNavigationBar: BottomNavigationBar(
            backgroundColor: Colors.black,
            currentIndex: selecteIndex,
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(icon: Icon(Icons.home), label: 'home'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.search), label: 'search'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.library_books), label: 'library'),
            ],
            onTap: (value) {
              setState(() {
                selecteIndex = value;
              });
            },
            unselectedItemColor: Colors.white,
            selectedItemColor: Colors.blue,
          )),
    );
  }
}
