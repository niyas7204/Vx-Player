import 'package:audio_player_final/screens/mini_player.dart';
import 'package:audio_player_final/widgets/common_widgets.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:audio_player_final/fuctions/database_functions.dart';
import 'package:audio_player_final/screens/playing_screen.dart';
import 'package:audio_player_final/fuctions/getall_song.dart';
import 'package:on_audio_query/on_audio_query.dart';

class MostplayedSc extends StatefulWidget {
  const MostplayedSc({super.key});

  @override
  State<MostplayedSc> createState() => _MostplayedScState();
}

class _MostplayedScState extends State<MostplayedSc> {
  List list = [];
  List listofId = [];
  List<SongModel> mostSongs = [];
  final mostPlayedBox = Hive.box('MostPlayed');
  List listOfMostPlayed = [];
  List orderlist = [];
  getsong() {
    setState(() {
      listofId = getMostPlayedSongs();

      listOfMostPlayed = mostPlayedBox.values.toList();
      Map<int, int> numberof = {
        for (var x in listofId.toSet())
          x: listofId.where((element) => element == x).length
      };
      orderlist = listofId
        ..sort(
          (a, b) => numberof[b]!.compareTo(numberof[a]!),
        );
    });
    mostSongs = takeSongs(orderlist);
  }

  @override
  void initState() {
    getsong();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(120, 0, 0, 0),
        appBar: AppBar(
          title: cText('Most Played'),
        ),
        body: SafeArea(
          child: Padding(
              padding: const EdgeInsets.all(10),
              child: Builder(
                builder: (context) {
                  if (mostSongs.isEmpty) {
                    return Center(child: emptyText('No Songs Found'));
                  } else {
                    return ListView.separated(
                        itemBuilder: (context, index) =>
                            songlist(mostSongs, index, context),
                        separatorBuilder: (context, index) => const SizedBox(
                              height: 10,
                            ),
                        itemCount: mostSongs.length);
                  }
                },
              )),
        ),
        bottomNavigationBar: const MiniPlayer());
  }

  List<SongModel> takeSongs(List id) {
    final list = id.toSet().toList();
    int l = GetAllSong.allSong.length;
    List<SongModel> rSongs = [];
    for (int j = 0; j < list.length; j++) {
      for (int i = 0; i < l; i++) {
        if (GetAllSong.allSong[i].id == list[j]) {
          rSongs.add(GetAllSong.allSong[i]);
        }
      }
    }
    return rSongs;
  }
}
