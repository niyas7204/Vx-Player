import 'package:audio_player_final/db/playlist_model.dart';
import 'package:audio_player_final/fuctions/database_functions.dart';
import 'package:audio_player_final/fuctions/getall_song.dart';
import 'package:audio_player_final/screens/library/playt_list/addtoplaylist.dart';
import 'package:audio_player_final/screens/mini_player.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class AllSongstoList extends StatefulWidget {
  int playlistIndex;
  AllSongstoList({super.key, required this.playlistIndex});

  @override
  State<AllSongstoList> createState() => _AllSongstoListState();
}

class _AllSongstoListState extends State<AllSongstoList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: ListView.separated(
            itemBuilder: (context, index) {
              return Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: const Color.fromARGB(88, 90, 169, 233)),
                child: ListTile(
                  onTap: () {
                    songADDtoplaylist(GetAllSong.allSong[index],
                        widget.playlistIndex, context);
                    Navigator.of(context).pop();
                  },
                  leading: const Icon(
                    Icons.music_note,
                    color: Colors.white,
                    size: 40,
                  ),
                  title: Text(
                    GetAllSong.allSong[index].displayName,
                    style: const TextStyle(color: Colors.white),
                    maxLines: 1,
                  ),
                  subtitle: Text(
                    GetAllSong.allSong[index].displayName,
                    style: const TextStyle(color: Colors.white),
                    maxLines: 1,
                  ),
                ),
              );
            },
            separatorBuilder: (context, index) => const SizedBox(
                  height: 10,
                ),
            itemCount: GetAllSong.allSong.length),
      ),
    );
  }
}
