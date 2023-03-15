import 'package:audio_player_final/fuctions/database_functions.dart';
import 'package:audio_player_final/fuctions/getall_song.dart';
import 'package:audio_player_final/screens/playing_screen.dart';
import 'package:flutter/material.dart';

class MiniPlayer extends StatefulWidget {
  const MiniPlayer({super.key});

  @override
  State<MiniPlayer> createState() => _MiniPlayerState();
}

class _MiniPlayerState extends State<MiniPlayer> {
  getState() {
    GetAllSong.axplayer.currentIndexStream.listen((index) {
      if (index != null && mounted) {
        setState(() {});
      }
    });
  }

  @override
  void initState() {
    getState();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      child: ValueListenableBuilder(
        valueListenable: GetAllSong.playerON,
        builder: (context, value, child) {
          if (value) {
            return ListTile(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) =>
                      PlayerSc(songModelList: GetAllSong.playingSong),
                ));
              },
              tileColor: Colors.black,
              title: Text(
                GetAllSong.playingSong[GetAllSong.currentindexes].title,
                style: const TextStyle(color: Colors.white),
                maxLines: 1,
              ),
              leading: const Icon(
                Icons.music_note,
                color: Colors.blue,
                size: 40,
              ),
              trailing: FittedBox(
                fit: BoxFit.fill,
                child: Row(
                  children: [
                    IconButton(
                        onPressed: () async {
                          if (GetAllSong.axplayer.hasPrevious) {
                            addtorecent(GetAllSong
                                .playingSong[
                                    GetAllSong.axplayer.currentIndex! - 1]
                                .id);
                            addToMostplayed(GetAllSong
                                .playingSong[
                                    GetAllSong.axplayer.currentIndex! - 1]
                                .id);
                            await GetAllSong.axplayer.seekToPrevious();
                            await GetAllSong.axplayer.play();
                          } else {
                            await GetAllSong.axplayer.play();
                          }
                        },
                        icon: const Icon(
                          Icons.skip_previous_outlined,
                          color: Colors.white,
                        )),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          minimumSize: const Size.fromRadius(30),
                          backgroundColor: Colors.blue,
                          shape: const CircleBorder()),
                      onPressed: () async {
                        if (GetAllSong.axplayer.playing) {
                          await GetAllSong.axplayer.pause();
                        } else {
                          GetAllSong.axplayer.play();
                        }
                        setState(() {});
                      },
                      child: Builder(builder: (context) {
                        getState();

                        return Icon(
                            GetAllSong.axplayer.playing
                                ? Icons.pause
                                : Icons.play_arrow,
                            size: 50);
                      }),
                    ),
                    IconButton(
                        onPressed: () async {
                          if (GetAllSong.axplayer.hasNext) {
                            addtorecent(GetAllSong
                                .playingSong[
                                    GetAllSong.axplayer.currentIndex! + 1]
                                .id);
                            addToMostplayed(GetAllSong
                                .playingSong[
                                    GetAllSong.axplayer.currentIndex! + 1]
                                .id);
                            await GetAllSong.axplayer.seekToNext();
                            await GetAllSong.axplayer.play();
                          } else {
                            await GetAllSong.axplayer.play();
                          }
                        },
                        icon: const Icon(
                          Icons.skip_next_outlined,
                          color: Colors.white,
                        )),
                  ],
                ),
              ),
            );
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }
}
