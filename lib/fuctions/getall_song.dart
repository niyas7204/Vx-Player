import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:just_audio_background/just_audio_background.dart';

class GetAllSong {
  static ValueNotifier<bool> playerON = ValueNotifier<bool>(false);
  static AudioPlayer axplayer = AudioPlayer();
  static List<SongModel> playingSong = [];
  static int currentindexes = -1;
  static late SongModel element;
  static List<SongModel> allSong = [];

  static ConcatenatingAudioSource createSonglist(List<SongModel> elements) {
    List<AudioSource> songList = [];

    playingSong = elements;

    for (element in elements) {
      songList.add(
        AudioSource.uri(Uri.parse(element.uri!),
            tag: MediaItem(
              id: element.id.toString(),
              title: element.title,
              album: element.album,
              artist: element.artist,
              artUri: Uri.parse(element.id.toString()),
            )),
      );
    }
    return ConcatenatingAudioSource(children: songList);
  }
}
