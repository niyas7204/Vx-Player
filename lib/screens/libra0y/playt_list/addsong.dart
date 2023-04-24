import 'package:audio_player_final/fuctions/database_functions.dart';
import 'package:audio_player_final/fuctions/getall_song.dart';

import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

class AllSongstoList extends StatelessWidget {
  final int playlistIndex;
  const AllSongstoList({super.key, required this.playlistIndex});

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
                    Provider.of<DbFucnctionsProvider>(context, listen: false)
                        .songADDtoplaylist(
                            GetAllSong.allSong[index], playlistIndex, context);
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
