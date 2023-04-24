import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
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
}
