import 'package:audio_player_final/fuctions/database_functions.dart';
import 'package:audio_player_final/fuctions/getall_song.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';

class GetlibarahSongProvider with ChangeNotifier {
  List<SongModel> recentSongs = [];
  List<SongModel> mostSongs = [];

  getrecentSongs(context) {
    Provider.of<DbFucnctionsProvider>(context, listen: false).addData();
    recentSongs = [];
    final list = Provider.of<DbFucnctionsProvider>(context)
        .recentSongId
        .reversed
        .toSet()
        .toList();
    int l = GetAllSong.allSong.length;

    for (int j = 0; j < list.length; j++) {
      for (int i = 0; i < l; i++) {
        if (GetAllSong.allSong[i].id == list[j]) {
          recentSongs.add(GetAllSong.allSong[i]);
        }
      }
    }
    notifyListeners();
  }

  orderMostPlayed(context) {
    Provider.of<DbFucnctionsProvider>(context, listen: false)
        .getMostPlayedSongs();
    mostSongs = [];
    List listofId = Provider.of<DbFucnctionsProvider>(context).mostSongId;
    Map<int, int> numberof = {
      for (var x in listofId.toSet())
        x: listofId.where((element) => element == x).length
    };
    List orderlist = listofId
      ..sort(
        (a, b) => numberof[b]!.compareTo(numberof[a]!),
      );
    int l = GetAllSong.allSong.length;
    List songlist = orderlist.toSet().toList();
    for (int j = 0; j < songlist.length; j++) {
      for (int i = 0; i < l; i++) {
        if (GetAllSong.allSong[i].id == orderlist[j]) {
          mostSongs.add(GetAllSong.allSong[i]);
        }
      }
    }
    notifyListeners();
  }
}
