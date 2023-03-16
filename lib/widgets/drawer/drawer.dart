import 'package:audio_player_final/fuctions/database_functions.dart';
import 'package:audio_player_final/fuctions/getall_song.dart';
import 'package:audio_player_final/widgets/drawer/aboutus.dart';
import 'package:audio_player_final/widgets/drawer/privacy.dart';
import 'package:flutter/material.dart';

class DrawerSc extends StatelessWidget {
  const DrawerSc({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
              decoration:
                  const BoxDecoration(color: Color.fromARGB(255, 0, 0, 0)),
              child: Column(
                children: const [
                  Icon(
                    Icons.queue_music_rounded,
                    color: Colors.white,
                    size: 30,
                  ),
                  Text(
                    'Vx Player',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                    ),
                  ),
                  Text(
                    'version 1.0.0',
                    style: TextStyle(
                        color: Color.fromARGB(255, 219, 219, 219),
                        fontSize: 15),
                  ),
                ],
              )),
          ListTile(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AboutUs(),
                  ));
            },
            title: Row(
              children: const [
                Icon(Icons.person),
                Text('About us'),
              ],
            ),
          ),
          ListTile(
            onTap: () {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Text(
                      'Reset App',
                      style: TextStyle(
                          color: Color.fromARGB(255, 219, 219, 219),
                          fontSize: 17,
                          fontWeight: FontWeight.w600),
                    ),
                    content: const Text("""
Are you sure want to reset the App?
your saved datas will be deleted
"""),
                    actions: [
                      TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text('NO')),
                      TextButton(
                          onPressed: () {
                            clearData(context);
                            GetAllSong.axplayer.stop();
                            GetAllSong.playerON.value = false;
                            Navigator.of(context).pop;
                          },
                          child: const Text('YES'))
                    ],
                  );
                },
              );
            },
            title: Row(
              children: const [
                Icon(Icons.restore),
                Text('Reset App'),
              ],
            ),
          ),
          ListTile(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const PrivacySc(),
              ));
            },
            title: Row(
              children: const [
                Icon(Icons.policy),
                Text('Privacy & Policy'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
