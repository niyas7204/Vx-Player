import 'package:audio_player_final/provider/audio_provider.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AudioQuaryProvider>(
      builder: (context, value, child) => WillPopScope(
        onWillPop: () async {
          if (value.selecteIndex == 0) {
            return true;
          }

          return false;
        },
        child: Scaffold(
            body: Container(child: value.pages[value.selecteIndex]),
            bottomNavigationBar: BottomNavigationBar(
              backgroundColor: Colors.black,
              currentIndex: value.selecteIndex,
              items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(icon: Icon(Icons.home), label: 'home'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.search), label: 'search'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.library_books), label: 'library'),
              ],
              onTap: (valueIndex) {
                value.changePageIndex(valueIndex);
              },
              unselectedItemColor: Colors.white,
              selectedItemColor: Colors.blue,
            )),
      ),
    );
  }
}
