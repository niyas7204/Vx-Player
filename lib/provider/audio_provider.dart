import 'package:audio_player_final/screens/allsongs.dart';
import 'package:audio_player_final/screens/librory.dart';
import 'package:audio_player_final/screens/search.dart';
import 'package:flutter/foundation.dart';
import 'package:on_audio_query/on_audio_query.dart';

class AudioQuaryProvider with ChangeNotifier {
  OnAudioQuery audioQuery = OnAudioQuery();
  requestPermission() async {
    if (!kIsWeb) {
      bool permissionStatus = await audioQuery.permissionsStatus();
      if (!permissionStatus) {
        await audioQuery.permissionsRequest();
      }
    }
    notifyListeners();
  }

  final pages = [const AllSongs(), const SearchSCreen(), const Library()];
  int selecteIndex = 0;
  willPop() {
    selecteIndex = 0;
    notifyListeners();
  }

  changePageIndex(value) {
    selecteIndex = value;
  }
}
