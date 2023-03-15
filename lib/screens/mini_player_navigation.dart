import 'package:audio_player_final/fuctions/getall_song.dart';
import 'package:audio_player_final/screens/mini_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class MiniPlayerNavigation extends StatefulWidget {
  const MiniPlayerNavigation({super.key});

  @override
  State<MiniPlayerNavigation> createState() => _MiniPlayerNavigationState();
}

class _MiniPlayerNavigationState extends State<MiniPlayerNavigation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(bottomNavigationBar: Builder(
      builder: (context) {
        setState(() {});
        if (GetAllSong.axplayer.currentIndex == null) {
          return const SizedBox();
        } else {
          return const MiniPlayer();
        }
      },
    ));
  }
}
