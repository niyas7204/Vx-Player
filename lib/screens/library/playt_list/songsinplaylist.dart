import 'dart:math';

import 'package:audio_player_final/fuctions/database_functions.dart';
import 'package:audio_player_final/screens/library/playt_list/addSong.dart';
import 'package:audio_player_final/screens/mini_player.dart';
import 'package:audio_player_final/widgets/common_widgets.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:audio_player_final/db/playlist_model.dart';
import 'package:audio_player_final/fuctions/getall_song.dart';
import 'package:audio_player_final/screens/playing_screen.dart';

class PLaylistSongs extends StatefulWidget {
  final int index;
  const PLaylistSongs({super.key, required this.index});

  @override
  State<PLaylistSongs> createState() => _PLaylistSongsState();
}

class _PLaylistSongsState extends State<PLaylistSongs> {
  late PlayListMOdel song;
  late List<SongModel> songdt;
  final sBox = Hive.box<PlayListMOdel>('playlist_Data');
  getSong() {
    setState(() {
      song = sBox.values.toList()[widget.index];
      songdt = listOFplaylist(song.songId);
    });
  }

  @override
  void initState() {
    getSong();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(title: Text(song.listName)),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      AllSongstoList(playlistIndex: widget.index),
                ));
          },
        ),
        body: SafeArea(
            child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: Builder(builder: (context) {
                if (songdt.isEmpty) {
                  return Center(child: emptyText('No Songs found'));
                } else {
                  return ListView.separated(
                      itemBuilder: (context, index) {
                        return Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: const Color.fromARGB(88, 90, 169, 233)),
                          child: ListTile(
                            onTap: () {
                              GetAllSong.axplayer.setAudioSource(
                                  GetAllSong.createSonglist(songdt),
                                  initialIndex: index);
                              GetAllSong.axplayer.play();
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => PlayerSc(
                                      songModelList: songdt,
                                    ),
                                  ));
                            },
                            title: Text(songdt[index].title,
                                maxLines: 1,
                                style: const TextStyle(color: Colors.white)),
                            subtitle: Text(
                              songdt[index].displayName,
                              maxLines: 1,
                              style: const TextStyle(color: Colors.white),
                            ),
                            leading: const Icon(
                              Icons.music_note,
                              color: Colors.white,
                            ),
                            trailing: PopupMenuButton(
                              color: Colors.white,
                              itemBuilder: (context) => [
                                PopupMenuItem(
                                    child: GestureDetector(
                                  onTap: () {
                                    song.songId.removeAt(index);
                                    songdt.removeAt(index);
                                    sBox.putAt(index, song);
                                    getSong();
                                    Navigator.of(context).pop();
                                  },
                                  child: Row(
                                    children: const [
                                      Text(
                                        'Delete from playlist',
                                      ),
                                      Icon(
                                        Icons.delete,
                                      )
                                    ],
                                  ),
                                )),
                                PopupMenuItem(child: Builder(
                                  builder: (context) {
                                    final bool fav =
                                        chekFavorite(songdt[index].id);
                                    if (!fav) {
                                      return GestureDetector(
                                        onTap: () {
                                          addToFavorites(
                                            songdt[index].id,
                                            context,
                                          );
                                          Navigator.of(context).pop();
                                        },
                                        child: Row(
                                          children: const [
                                            Text(
                                              'Add to favorite',
                                            ),
                                            Icon(
                                              Icons.favorite_sharp,
                                            )
                                          ],
                                        ),
                                      );
                                    } else {
                                      return GestureDetector(
                                        onTap: () {
                                          deleteFAvorite(
                                              songdt[index].id, context);
                                          Navigator.of(context).pop();
                                        },
                                        child: Row(
                                          children: const [
                                            Text(
                                              'delete from favorite',
                                            ),
                                            Icon(Icons.favorite_sharp)
                                          ],
                                        ),
                                      );
                                    }
                                  },
                                ))
                              ],
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (context, index) => const SizedBox(
                            height: 10,
                          ),
                      itemCount: songdt.length);
                }
              }),
            ),
          ],
        )),
        bottomNavigationBar: const MiniPlayer());
  }

  List<SongModel> listOFplaylist(List<int> id) {
    int l = GetAllSong.allSong.length;
    List<SongModel> songs = [];
    for (int i = 0; i < l; i++) {
      for (int j = 0; j < id.length; j++) {
        if (GetAllSong.allSong[i].id == id[j]) {
          songs.add(GetAllSong.allSong[i]);
        }
      }
    }
    return songs;
  }
}
