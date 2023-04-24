import 'dart:developer';

import 'package:audio_player_final/fuctions/database_functions.dart';
import 'package:audio_player_final/fuctions/getall_song.dart';
import 'package:flutter/material.dart';

import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';

class GetlibarahSongProvider with ChangeNotifier {
  List<SongModel> recentSongs = [];
  List<SongModel> mostSongs = [];
  List<SongModel> favSongs = [];
  List<SongModel> playlistSongs = [];

  getrecentSongs(context) {
    Provider.of<DbFucnctionsProvider>(context, listen: false).addData();
    recentSongs = [];
    final list = Provider.of<DbFucnctionsProvider>(context)
        .recentSongId
        .reversed
        .toSet()
        .toList();

    getSong(list, recentSongs);
    notifyListeners();
  }

  orderMostPlayed(context) {
    Provider.of<DbFucnctionsProvider>(context, listen: false)
        .getMostPlayedSongs();
    mostSongs = [];
    List listofId = Provider.of<DbFucnctionsProvider>(context).mostSongId;

    Map<dynamic, int> numberof = {
      for (var x in listofId.toSet())
        x: listofId.where((element) => element == x).length
    };
    List orderlist = listofId
      ..sort(
        (a, b) => numberof[b]!.compareTo(numberof[a]!),
      );

    List songlist = orderlist.toSet().toList();
    getSong(songlist, mostSongs);
    notifyListeners();
  }

  getFavSong(context) {
    favSongs = [];
    Provider.of<DbFucnctionsProvider>(context, listen: false).addData();
    final list = Provider.of<DbFucnctionsProvider>(context).favSongId;
    getSong(list, favSongs);
    notifyListeners();
  }

  getPlaylistSongs(context, index) {
    Provider.of<DbFucnctionsProvider>(context, listen: false).addData();
    playlistSongs = [];
    List list =
        Provider.of<DbFucnctionsProvider>(context).playList[index].songId;
    getSong(list, playlistSongs);
  }

  getSong(List id, List songs) {
    for (int j = 0; j < id.length; j++) {
      for (int i = 0; i < GetAllSong.allSong.length; i++) {
        if (GetAllSong.allSong[i].id == id[j]) {
          songs.add(GetAllSong.allSong[i]);
        }
      }
    }
  }
}
