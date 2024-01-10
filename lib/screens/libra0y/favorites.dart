import 'package:audio_player_final/fuctions/database_functions.dart';
import 'package:audio_player_final/provider/get_library_provider.dart';
import 'package:audio_player_final/screens/libra0y/playt_list/addtoplaylist.dart';
import 'package:audio_player_final/screens/mini_player.dart';
import 'package:audio_player_final/screens/playing_screen.dart';
import 'package:audio_player_final/widgets/common_widgets.dart';
import 'package:flutter/material.dart';

import 'package:audio_player_final/fuctions/getall_song.dart';

import 'package:provider/provider.dart';

class FavoritesSC extends StatelessWidget {
  const FavoritesSC({super.key});

  @override
  Widget build(BuildContext context) {
    Provider.of<GetlibarahSongProvider>(context, listen: false)
        .getFavSong(context);
    return Consumer<GetlibarahSongProvider>(
      builder: (context, value, child) => Scaffold(
          appBar: AppBar(
            title: const Row(
              children: [Text('Favorites'), Icon(Icons.favorite)],
            ),
          ),
          body: SafeArea(
              child: Container(
            color: Colors.black,
            child: Padding(
                padding: const EdgeInsets.all(10),
                child: Builder(
                  builder: (context) {
                    if (value.favSongs.isEmpty) {
                      return Center(child: emptyText('No Favorite songs'));
                    } else {
                      return ListView.separated(
                          itemBuilder: (context, index) {
                            return Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color:
                                      const Color.fromARGB(88, 90, 169, 233)),
                              child: ListTile(
                                  onTap: () {
                                    Provider.of<DbFucnctionsProvider>(context,
                                            listen: false)
                                        .addToMostplayed(
                                            value.favSongs[index].id);
                                    Provider.of<DbFucnctionsProvider>(context,
                                            listen: false)
                                        .addtorecent(value.favSongs[index].id);
                                    GetAllSong.axplayer.setAudioSource(
                                        GetAllSong.createSonglist(
                                            value.favSongs),
                                        initialIndex: index);
                                    GetAllSong.axplayer.play();
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => PlayerSc(
                                            songModelList: value.favSongs,
                                          ),
                                        ));
                                  },
                                  leading: const Icon(
                                    Icons.music_note,
                                    color: Colors.white,
                                    size: 40,
                                  ),
                                  title: Text(
                                    value.favSongs[index].displayName,
                                    style: const TextStyle(color: Colors.white),
                                    maxLines: 1,
                                  ),
                                  subtitle: Text(
                                    value.favSongs[index].displayName,
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
                                                allSong: value.favSongs[index]),
                                          ));
                                        },
                                        child: const Row(
                                          children: [
                                            Text('Add to playlist'),
                                            Icon(Icons.add)
                                          ],
                                        ),
                                      )),
                                      PopupMenuItem(child: Builder(
                                        builder: (context) {
                                          return GestureDetector(
                                            onTap: () {
                                              Provider.of<DbFucnctionsProvider>(
                                                      context,
                                                      listen: false)
                                                  .deleteFAvorite(
                                                      value.favSongs[index].id,
                                                      context);
                                              Navigator.of(context).pop();
                                            },
                                            child: const Row(
                                              children: [
                                                Text('delete from favorite'),
                                                Icon(Icons.favorite_sharp)
                                              ],
                                            ),
                                          );
                                        },
                                      ))
                                    ],
                                  )),
                            );
                          },
                          separatorBuilder: (context, index) => const SizedBox(
                                height: 10,
                              ),
                          itemCount: value.favSongs.length);
                    }
                  },
                )),
          )),
          bottomNavigationBar: const MiniPlayer()),
    );
  }
}
