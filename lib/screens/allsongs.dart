import 'package:audio_player_final/screens/library/favorites.dart';
import 'package:audio_player_final/screens/library/most_played.dart';
import 'package:audio_player_final/screens/library/playt_list/create_playlist.dart';
import 'package:audio_player_final/screens/library/recent_playlist.dart';
import 'package:audio_player_final/screens/mini_player.dart';
import 'package:audio_player_final/widgets/common_widgets.dart';
import 'package:audio_player_final/widgets/drawer/drawer.dart';
import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:flutter/foundation.dart';
import 'package:audio_player_final/fuctions/getall_song.dart';

class AllSongs extends StatefulWidget {
  const AllSongs({Key? key}) : super(key: key);

  @override
  State<AllSongs> createState() => _AllSongsState();
}

class _AllSongsState extends State<AllSongs> {
  late int index;
  List<SongModel> allitem = [];
  final OnAudioQuery _audioQuery = OnAudioQuery();

  @override
  void initState() {
    super.initState();
    requestPermission();
  }

  requestPermission() async {
    if (!kIsWeb) {
      bool permissionStatus = await _audioQuery.permissionsStatus();
      if (!permissionStatus) {
        await _audioQuery.permissionsRequest();
      }
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 0, 0, 0),
          title: Center(
            child: cText('Vx Player'),
          ),
        ),
        drawer: const Drawer(
          child: DrawerSc(),
        ),
        backgroundColor: Colors.black,
        body: SafeArea(
          minimum: const EdgeInsets.all(15),
          child: Container(
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(
                        'assets/images/HD-wallpaper-music-notes-thumbnail.jpg'))),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        liberyCard(
                            'RecentPlayed', context, const RecentlyPlayed()),
                        liberyCard('MostPlayed', context, const MostplayedSc()),
                        liberyCard('Playlist', context, const CreatePlaylist()),
                        liberyCard('favorite', context, const FavoritesSC()),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: cText('All Songs'),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  FutureBuilder<List<SongModel>>(
                    future: _audioQuery.querySongs(
                      sortType: null,
                      orderType: OrderType.ASC_OR_SMALLER,
                      uriType: UriType.EXTERNAL,
                      ignoreCase: true,
                    ),
                    builder: (context, item) {
                      if (item.data == null) {
                        return const CircularProgressIndicator();
                      } else if (item.data!.isEmpty) {
                        return const Text("Nothing found!");
                      }

                      GetAllSong.allSong = item.data!;
                      return ListView.separated(
                        separatorBuilder: (context, index) => const SizedBox(
                          height: 10,
                        ),
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: item.data!.length,
                        itemBuilder: (context, index) {
                          return songlist(item.data!, index, context);
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: const MiniPlayer());
  }
}