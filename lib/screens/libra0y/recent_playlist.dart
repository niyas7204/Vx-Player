import 'package:audio_player_final/screens/mini_player.dart';
import 'package:audio_player_final/widgets/common_widgets.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:audio_player_final/fuctions/getall_song.dart';
import 'package:on_audio_query/on_audio_query.dart';

class RecentlyPlayed extends StatefulWidget {
  const RecentlyPlayed({super.key});

  @override
  State<RecentlyPlayed> createState() => _RecentlyPlayedState();
}

class _RecentlyPlayedState extends State<RecentlyPlayed> {
  final recenBox = Hive.box<int>('recentlyPlayed');
  late List<SongModel> songs;
  getlist() {
    setState(() {
      final id = recenBox.values.toList();

      songs = recentSongs(id);
    });
  }

  @override
  void initState() {
    getlist();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(120, 0, 0, 0),
        appBar: AppBar(
            title: Row(
          children: const [
            Text('RecentPlaylist'),
            Icon(Icons.replay_circle_filled_outlined)
          ],
        )),
        body: Padding(
            padding: const EdgeInsets.all(10),
            child: Builder(
              builder: (context) {
                if (songs.isEmpty) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 70, left: 10),
                    child: Center(
                      child: emptyText('No recent songs'),
                    ),
                  );
                } else {
                  return ListView.separated(
                      itemBuilder: (context, index) =>
                          songlist(songs, index, context),
                      separatorBuilder: (context, index) => const SizedBox(
                            height: 10,
                          ),
                      itemCount: songs.length);
                }
              },
            )),
        bottomNavigationBar: const MiniPlayer());
  }

  List<SongModel> recentSongs(List<int> id) {
    final list = id.reversed.toSet().toList();
    int l = GetAllSong.allSong.length;
    List<SongModel> rSongs = [];
    for (int j = 0; j < list.length; j++) {
      for (int i = 0; i < l; i++) {
        if (GetAllSong.allSong[i].id == list[j]) {
          rSongs.add(GetAllSong.allSong[i]);
        }
      }
    }
    return rSongs;
  }
}
