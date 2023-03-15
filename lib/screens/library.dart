import 'package:audio_player_final/db/playlist_model.dart';
import 'package:audio_player_final/fuctions/getall_song.dart';
import 'package:audio_player_final/screens/library/playt_list/songsinplaylist.dart';
import 'package:audio_player_final/screens/mini_player.dart';
import 'package:flutter/material.dart';
import 'package:audio_player_final/widgets/common_widgets.dart';
import 'package:audio_player_final/screens/library/recent_playlist.dart';
import 'package:audio_player_final/screens/library/favorites.dart';
import 'package:audio_player_final/screens/library/most_played.dart';
import 'package:hive_flutter/hive_flutter.dart';

class Library extends StatefulWidget {
  const Library({super.key});

  @override
  State<Library> createState() => _LibraryState();
}

class _LibraryState extends State<Library> {
  List<PlayListMOdel> playLIst = [];

  final plBox = Hive.box<PlayListMOdel>('playlist_Data');
  getList() {
    setState(() {
      playLIst = plBox.values.toList();
    });
  }

  @override
  void initState() {
    getList();
    super.initState();
  }

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
                child: ListView.separated(
                    itemBuilder: (context, index) {
                      return ListTile(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => PLaylistSongs(index: index),
                          ));
                        },
                        leading: const Icon(
                          Icons.folder_copy,
                          size: 40,
                        ),
                        title: Text(playLIst[index].listName),
                        trailing: IconButton(
                            onPressed: () {
                              showDeleteForm(index);
                            },
                            icon: const Icon(Icons.delete)),
                      );
                    },
                    separatorBuilder: (context, index) => const SizedBox(
                          height: 10,
                        ),
                    itemCount: playLIst.length),
              )
            ],
          ),
        ),
      ),
    );
  }

  showDeleteForm(index) {
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
                      plBox.deleteAt(index);
                      playLIst.removeAt(index);
                      getList();
                      Navigator.of(context).pop();
                    },
                    child: const Text('delete')),
              ],
            ));
  }
}
