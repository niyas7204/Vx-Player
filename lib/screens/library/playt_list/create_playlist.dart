import 'package:audio_player_final/screens/mini_player.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:audio_player_final/fuctions/database_functions.dart';
import 'package:audio_player_final/db/playlist_model.dart';
import 'package:audio_player_final/widgets/common_widgets.dart';
import 'package:audio_player_final/screens/library/playt_list/songsinplaylist.dart';

class CreatePlaylist extends StatefulWidget {
  const CreatePlaylist({super.key});

  @override
  State<CreatePlaylist> createState() => _CreatePlaylistState();
}

class _CreatePlaylistState extends State<CreatePlaylist> {
  List<PlayListMOdel> playLIst = [];

  TextEditingController newPlaylistController = TextEditingController();
  final plBox = Hive.box<PlayListMOdel>('playlist_Data');
  void getPlaylist() {
    playLIst = plBox.values.toList();
    setState(() {});
  }

  @override
  void initState() {
    getPlaylist();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
              Builder(
                builder: (context) {
                  if (playLIst.isEmpty) {
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
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) =>
                                      PLaylistSongs(index: index),
                                ));
                              },
                              leading: const Icon(
                                Icons.folder_copy,
                                size: 40,
                                color: Colors.white,
                              ),
                              title: Text(
                                playLIst[index].listName,
                                style: const TextStyle(color: Colors.white),
                              ),
                              trailing: IconButton(
                                  onPressed: () {
                                    showDeleteForm(index);
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
                          itemCount: playLIst.length),
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
                createPlaylist(newPlaylistController.text, context);
                getPlaylist();
                Navigator.of(context).pop();
                newPlaylistController.clear();
              },
              child: const Text('create'),
            )
          ],
        );
      },
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
                      getPlaylist();
                      Navigator.of(context).pop();
                    },
                    child: const Text('delete')),
              ],
            ));
  }
}
