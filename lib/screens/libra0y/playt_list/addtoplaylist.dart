import 'package:audio_player_final/screens/mini_player.dart';
import 'package:flutter/material.dart';
import 'package:audio_player_final/db/playlist_model.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive/hive.dart';
import 'package:audio_player_final/widgets/common_widgets.dart';
import 'package:audio_player_final/fuctions/database_functions.dart';
import 'package:provider/provider.dart';

class AddToPlaylist extends StatelessWidget {
  final SongModel allSong;
  const AddToPlaylist({super.key, required this.allSong});

  @override
  Widget build(BuildContext context) {
    Provider.of<DbFucnctionsProvider>(context).addData();
    return Scaffold(
        backgroundColor: Colors.black,
        body: SafeArea(
            child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              GestureDetector(
                onTap: () {
                  newPlaylistform(context);
                },
                child: Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.blue),
                      child: Row(
                        children: const [
                          Icon(Icons.add),
                          Text('create new playlist')
                        ],
                      )),
                ),
              ),
              Consumer<DbFucnctionsProvider>(
                builder: (context, value, child) {
                  if (value.playList.isEmpty) {
                    return Expanded(
                      child: Center(
                        child: emptyText('No Playlist Found'),
                      ),
                    );
                  } else {
                    return Expanded(
                      child: ListView.separated(
                          itemBuilder: (context, index) {
                            return ListTile(
                              onTap: () {
                                Provider.of<DbFucnctionsProvider>(context,
                                        listen: false)
                                    .songADDtoplaylist(allSong, index, context);
                              },
                              leading: const Icon(
                                Icons.folder_copy,
                                size: 40,
                                color: Colors.white,
                              ),
                              title: Text(value.playList[index].listName,
                                  style: const TextStyle(color: Colors.white)),
                            );
                          },
                          separatorBuilder: (context, index) => const SizedBox(
                                height: 10,
                              ),
                          itemCount: value.playList.length),
                    );
                  }
                },
              )
            ],
          ),
        )),
        bottomNavigationBar: const MiniPlayer());
  }

  void newPlaylistform(BuildContext context) {
    TextEditingController newPlaylistController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: cText('New Playlist'),
          content: Form(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: TextFormField(
                controller: newPlaylistController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Playlist Name',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'empty not allowed';
                  } else if (value.trim().isEmpty) {
                    return 'empty not allowed';
                  }
                  return null;
                },
              ),
            ),
          ),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text(
                  'cancel',
                  style: TextStyle(color: Colors.black),
                )),
            TextButton(
              onPressed: () async {
                if (newPlaylistController.text.isNotEmpty) {
                  Provider.of<DbFucnctionsProvider>(context, listen: false)
                      .createPlaylist(newPlaylistController.text, context);
                  Navigator.of(context).pop();
                }
              },
              child: const Text('create'),
            )
          ],
        );
      },
    );
  }
}
