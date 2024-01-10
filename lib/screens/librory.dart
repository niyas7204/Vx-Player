import 'package:audio_player_final/fuctions/database_functions.dart';
import 'package:audio_player_final/screens/libra0y/playt_list/songsinplaylist.dart';
import 'package:flutter/material.dart';
import 'package:audio_player_final/widgets/common_widgets.dart';
import 'package:audio_player_final/screens/libra0y/recent_playlist.dart';
import 'package:audio_player_final/screens/libra0y/favorites.dart';
import 'package:audio_player_final/screens/libra0y/most_played.dart';
import 'package:provider/provider.dart';

class Library extends StatelessWidget {
  const Library({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('library'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    liberyCard('RcentPlayed', context, const RecentlyPlayed()),
                    liberyCard('MostPlayed', context, const MostplayedSc()),
                    liberyCard('favorite', context, const FavoritesSC()),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.topLeft,
                child: cText('Playlist'),
              ),
              Expanded(
                child: Consumer<DbFucnctionsProvider>(
                  builder: (context, value, child) => ListView.separated(
                      itemBuilder: (context, index) {
                        return ListTile(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) =>
                                  PLaylistSongs(playlistindex: index),
                            ));
                          },
                          leading: const Icon(
                            Icons.folder_copy,
                            size: 40,
                            color: Colors.white,
                          ),
                          title: Text(
                            value.playList[index].listName,
                            style: const TextStyle(color: Colors.white),
                          ),
                          trailing: IconButton(
                              onPressed: () {
                                showDeleteForm(index, context);
                              },
                              icon: const Icon(
                                Icons.delete,
                                color: Colors.white,
                              )),
                        );
                      },
                      separatorBuilder: (context, index) => const SizedBox(
                            height: 10,
                          ),
                      itemCount: value.playList.length),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  showDeleteForm(index, context) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: const Text('Do You Want To Delete Playlist'),
              actions: [
                TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text('cancel')),
                TextButton(
                    onPressed: () {
                      Provider.of<DbFucnctionsProvider>(context, listen: false)
                          .deletePlayList(index);
                      Navigator.of(context).pop();
                    },
                    child: const Text('delete')),
              ],
            ));
  }
}
