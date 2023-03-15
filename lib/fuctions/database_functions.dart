import 'package:audio_player_final/screens/allsongs.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:audio_player_final/db/playlist_model.dart';

void songADDtoplaylist(SongModel songDT, int index, context) {
  final plBox = Hive.box<PlayListMOdel>('playlist_Data');
  final data = plBox.values.toList()[index];
  if (!data.songId.contains(songDT.id)) {
    data.songId.add(songDT.id);
    plBox.putAt(index, data);
    SnackBar snackBar = const SnackBar(content: Text('song added to playList'));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
    Navigator.of(context).pop();
  } else {
    SnackBar snackBar = const SnackBar(content: Text('song exist in playlist'));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
    Navigator.of(context).pop();
  }
}

void createPlaylist(name, context) {
  if (name.isNotEmpty) {
    int flag = 0;
    late SnackBar snackbar;
    final plBox = Hive.box<PlayListMOdel>('playlist_Data');
    final list = plBox.values.toList();
    for (int i = 0; i < list.length; i++) {
      if (list[i].listName.contains(name)) {
        flag = 1;
      }
    }
    if (flag != 1) {
      final PlayListMOdel listData = PlayListMOdel(listName: name, songId: []);
      plBox.add(listData);
      snackbar = const SnackBar(content: Text('playList created succesfully'));
    } else {
      snackbar =
          const SnackBar(content: Text('file already exist change the name'));
    }
    ScaffoldMessenger.of(context).showSnackBar(snackbar);
  }
}

addToFavorites(int songId, context) {
  SnackBar snackbar;
  final fvBox = Hive.box<int>('favorite_songs');
  final fvList = fvBox.values.toList();
  if (!fvList.contains(songId)) {
    fvBox.add(songId);
    snackbar = const SnackBar(content: Text('song added to favorites'));
  } else {
    snackbar = const SnackBar(content: Text('song exist in favorites'));
  }
  ScaffoldMessenger.of(context).showSnackBar(snackbar);
}

addtorecent(id) {
  final recentBox = Hive.box<int>('recentlyPlayed');
  final list = recentBox.values.toList();

  if (list.length >= 20) {
    recentBox.deleteAt(0);
  }
  recentBox.add(id);
}

addToMostplayed(id) async {
  final mostPlayed = Hive.box('MostPlayed');
  mostPlayed.add(id);
}

List getMostPlayedSongs() {
  List<int> mostPlayed = [];
  final mostPlayedBox = Hive.box('MostPlayed');
  final mostPlayedItems = mostPlayedBox.values.toList();
  int count;
  for (int i = 0; i < mostPlayedItems.length; i++) {
    count = 0;
    for (int j = 0; j < mostPlayedItems.length; j++) {
      if (mostPlayedItems[i] == mostPlayedItems[j]) {
        count++;
      }
    }
    if (count >= 4) {
      mostPlayed.add(mostPlayedItems[i]);
    }
  }
  return mostPlayed;
}

deleteFAvorite(int id, context) {
  SnackBar snackbar;
  final favbox = Hive.box<int>('favorite_songs');
  final favlist = favbox.values.toList();
  for (int i = 0; i < favlist.length; i++) {
    if (favlist[i] == id) {
      favbox.deleteAt(i);
      snackbar = const SnackBar(content: Text('song deleted from favorites'));
      ScaffoldMessenger.of(context).showSnackBar(snackbar);
    }
  }
}

chekFavorite(id) {
  final favBox = Hive.box<int>('favorite_songs');
  final favList = favBox.values.toList();
  bool favorite = false;
  if (favList.contains(id)) {
    favorite = true;
  } else {
    favorite = false;
  }
  return favorite;
}

clearData(context) {
  final recentBox = Hive.box<int>('recentlyPlayed');
  final mostPlayedBox = Hive.box('MostPlayed');
  final favbox = Hive.box<int>('favorite_songs');
  final plBox = Hive.box<PlayListMOdel>('playlist_Data');
  recentBox.clear();
  mostPlayedBox.clear();
  favbox.clear();
  plBox.clear();
  Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (context) => const AllSongs(),
      ),
      (route) => false);
}
