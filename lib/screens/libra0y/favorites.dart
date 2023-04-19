import 'package:audio_player_final/fuctions/database_functions.dart';
import 'package:audio_player_final/screens/libra0y/playt_list/addtoplaylist.dart';
import 'package:audio_player_final/screens/mini_player.dart';
import 'package:audio_player_final/screens/playing_screen.dart';
import 'package:audio_player_final/widgets/common_widgets.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:audio_player_final/fuctions/getall_song.dart';
import 'package:on_audio_query/on_audio_query.dart';

class FavoritesSC extends StatefulWidget {
  const FavoritesSC({super.key});

  @override
  State<FavoritesSC> createState() => _FavoritesSCState();
}

class _FavoritesSCState extends State<FavoritesSC> {
  final favBox = Hive.box<int>('favorite_songs');
  late bool fav;
  late List<SongModel> songDAta;
  getFAvSong() {
    setState(() {
      final id = favBox.values.toList();
      songDAta = favSongs(id);
    });
  }

  @override
  void initState() {
    getFAvSong();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Row(
            children: const [Text('Favorites'), Icon(Icons.favorite)],
          ),
        ),
        body: SafeArea(
            child: Container(
          color: Colors.black,
          child: Padding(
              padding: const EdgeInsets.all(10),
              child: Builder(
                builder: (context) {
                  if (songDAta.isEmpty) {
                    return Center(child: emptyText('No Favorite songs'));
                  } else {
                    return ListView.separated(
                        itemBuilder: (context, index) {
                          return Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: const Color.fromARGB(88, 90, 169, 233)),
                            child: ListTile(
                                onTap: () {
                                  addToMostplayed(songDAta[index].id);
                                  addtorecent(songDAta[index].id);
                                  GetAllSong.axplayer.setAudioSource(
                                      GetAllSong.createSonglist(songDAta),
                                      initialIndex: index);
                                  GetAllSong.axplayer.play();
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => PlayerSc(
                                          songModelList: songDAta,
                                        ),
                                      ));
                                },
                                leading: const Icon(
                                  Icons.music_note,
                                  color: Colors.white,
                                  size: 40,
                                ),
                                title: Text(
                                  songDAta[index].displayName,
                                  style: const TextStyle(color: Colors.white),
                                  maxLines: 1,
                                ),
                                subtitle: Text(
                                  songDAta[index].displayName,
                                  style: const TextStyle(color: Colors.white),
                                  maxLines: 1,
                                ),
                                trailing: PopupMenuButton(
                                  icon: const Icon(
                                    Icons.more_vert,
                                    color: Colors.white,
                                  ),
                                  itemBuilder: (context) => [
                                    PopupMenuItem(
                                        child: GestureDetector(
                                      onTap: () {
                                        Navigator.of(context).pop();
                                        Navigator.of(context)
                                            .push(MaterialPageRoute(
                                          builder: (context) => AddToPlaylist(
                                              allSong: songDAta[index]),
                                        ));
                                      },
                                      child: Row(
                                        children: const [
                                          Text('Add to playlist'),
                                          Icon(Icons.add)
                                        ],
                                      ),
                                    )),
                                    PopupMenuItem(child: Builder(
                                      builder: (context) {
                                        final bool fav =
                                            chekFavorite(songDAta[index].id);
                                        if (!fav) {
                                          return GestureDetector(
                                            onTap: () {
                                              addToFavorites(
                                                  songDAta[index].id, context);
                                              Navigator.of(context).pop();
                                              getFAvSong();
                                            },
                                            child: Row(
                                              children: const [
                                                Text('Add to favorite'),
                                                Icon(Icons.favorite_sharp)
                                              ],
                                            ),
                                          );
                                        } else {
                                          return GestureDetector(
                                            onTap: () {
                                              deleteFAvorite(
                                                  songDAta[index].id, context);
                                              Navigator.of(context).pop();
                                              getFAvSong();
                                            },
                                            child: Row(
                                              children: const [
                                                Text('delete from favorite'),
                                                Icon(Icons.favorite_sharp)
                                              ],
                                            ),
                                          );
                                        }
                                      },
                                    ))
                                  ],
                                )),
                          );
                        },
                        separatorBuilder: (context, index) => const SizedBox(
                              height: 10,
                            ),
                        itemCount: songDAta.length);
                  }
                },
              )),
        )),
        bottomNavigationBar: const MiniPlayer());
  }

  List<SongModel> favSongs(List<int> id) {
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
