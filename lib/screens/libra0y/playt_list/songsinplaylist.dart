import 'dart:math';

import 'package:audio_player_final/fuctions/database_functions.dart';
import 'package:audio_player_final/provider/get_library_provider.dart';
import 'package:audio_player_final/screens/libra0y/playt_list/addsong.dart';
import 'package:audio_player_final/screens/mini_player.dart';
import 'package:audio_player_final/widgets/common_widgets.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:audio_player_final/db/playlist_model.dart';
import 'package:audio_player_final/fuctions/getall_song.dart';
import 'package:audio_player_final/screens/playing_screen.dart';
import 'package:provider/provider.dart';

class PLaylistSongs extends StatelessWidget {
  final int playlistindex;
  const PLaylistSongs({super.key, required this.playlistindex});

  @override
  Widget build(BuildContext context) {
    Provider.of<GetlibarahSongProvider>(context)
        .getPlaylistSongs(context, playlistindex);
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
            title: Consumer<DbFucnctionsProvider>(
                builder: (context, value, child) =>
                    Text(value.playList[playlistindex].listName))),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      AllSongstoList(playlistIndex: playlistindex),
                ));
          },
        ),
        body: SafeArea(
            child: Consumer<GetlibarahSongProvider>(
          builder: (context, value, child) => Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              Expanded(
                child: Builder(builder: (context) {
                  if (value.playlistSongs.isEmpty) {
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
                                    GetAllSong.createSonglist(
                                        value.playlistSongs),
                                    initialIndex: index);
                                GetAllSong.axplayer.play();
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => PlayerSc(
                                        songModelList: value.playlistSongs,
                                      ),
                                    ));
                              },
                              title: Text(value.playlistSongs[index].title,
                                  maxLines: 1,
                                  style: const TextStyle(color: Colors.white)),
                              subtitle: Text(
                                value.playlistSongs[index].displayName,
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
                                      Provider.of<DbFucnctionsProvider>(context,
                                              listen: false)
                                          .deleteFromPlayList(
                                              playlistindex,
                                              index,
                                              value.playlistSongs[index].id);
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
                                      final bool fav = Provider.of<
                                                  DbFucnctionsProvider>(context,
                                              listen: false)
                                          .chekFavorite(
                                              value.playlistSongs[index].id);
                                      if (!fav) {
                                        return GestureDetector(
                                          onTap: () {
                                            Provider.of<DbFucnctionsProvider>(
                                                    context,
                                                    listen: false)
                                                .addToFavorites(
                                              value.playlistSongs[index].id,
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
                                            Provider.of<DbFucnctionsProvider>(
                                                    context,
                                                    listen: false)
                                                .deleteFAvorite(
                                                    value.playlistSongs[index]
                                                        .id,
                                                    context);
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
                        itemCount: value.playlistSongs.length);
                  }
                }),
              ),
            ],
          ),
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
