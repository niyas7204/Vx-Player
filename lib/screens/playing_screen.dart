import 'package:audio_player_final/fuctions/database_functions.dart';
import 'package:audio_player_final/screens/libra0y/playt_list/addtoplaylist.dart';
import 'package:just_audio/just_audio.dart';

import 'package:on_audio_query/on_audio_query.dart';
import 'package:flutter/material.dart';
import 'package:audio_player_final/fuctions/getall_song.dart';
import 'package:provider/provider.dart';

class PlayerSc extends StatefulWidget {
  final List<SongModel> songModelList;

  const PlayerSc({super.key, required this.songModelList});

  @override
  State<PlayerSc> createState() => _PlayerScState();
}

class _PlayerScState extends State<PlayerSc> {
  bool fav = false;
  Duration duration = const Duration();
  Duration position = const Duration();

  bool isShuffle = false;
  int currentindex = 0;

  getsong() {
    GetAllSong.axplayer.play();
    GetAllSong.axplayer.currentIndexStream.listen((index) {
      if (index != null) {
        setState(() {
          GetAllSong.playerON.value = true;
          currentindex = index;
        });
        GetAllSong.currentindexes = index;
        fav = Provider.of<DbFucnctionsProvider>(context)
            .chekFavorite(GetAllSong.playingSong[currentindex].id);
      }
    });
    playSong();
  }

  @override
  void initState() {
    getsong();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 149, 186, 216),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            SizedBox(height: MediaQuery.of(context).size.height * .04),
            ClipRRect(
              child: Align(
                alignment: Alignment.center,
                child: SizedBox(
                    width: MediaQuery.of(context).size.width * .95,
                    height: MediaQuery.of(context).size.height * .50,
                    child: const Icon(
                      Icons.music_note,
                      size: 200,
                    )),
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * .04),
            Align(
              alignment: Alignment.centerLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.songModelList[currentindex].displayName,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(color: Colors.white, fontSize: 25),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          IconButton(
                              onPressed: () {
                                GetAllSong.axplayer.loopMode == LoopMode.one
                                    ? GetAllSong.axplayer
                                        .setLoopMode(LoopMode.all)
                                    : GetAllSong.axplayer
                                        .setLoopMode(LoopMode.one);
                              },
                              icon: StreamBuilder<LoopMode>(
                                stream: GetAllSong.axplayer.loopModeStream,
                                builder: (context, snapshot) {
                                  final loopMode = snapshot.data;
                                  if (LoopMode.one == loopMode) {
                                    return const Icon(
                                      Icons.repeat,
                                      color: Colors.red,
                                    );
                                  } else {
                                    return const Icon(
                                      Icons.repeat,
                                      color: Colors.white,
                                    );
                                  }
                                },
                              )),
                          IconButton(
                              onPressed: () {
                                isShuffle == false
                                    ? GetAllSong.axplayer
                                        .setShuffleModeEnabled(true)
                                    : GetAllSong.axplayer
                                        .setShuffleModeEnabled(false);
                              },
                              icon: StreamBuilder<bool>(
                                stream: GetAllSong
                                    .axplayer.shuffleModeEnabledStream,
                                builder: (BuildContext context,
                                    AsyncSnapshot snapshot) {
                                  isShuffle = snapshot.data;
                                  if (isShuffle) {
                                    return const Icon(
                                      Icons.shuffle,
                                      color: Colors.red,
                                    );
                                  } else {
                                    return const Icon(
                                      Icons.shuffle,
                                      color: Color.fromARGB(255, 255, 255, 255),
                                    );
                                  }
                                },
                              )),
                        ],
                      ),
                      Row(
                        children: [
                          IconButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => AddToPlaylist(
                                          allSong: GetAllSong.element),
                                    ));
                              },
                              icon: const Icon(Icons.playlist_add)),
                          IconButton(
                              onPressed: () async {
                                if (fav) {
                                  Provider.of<DbFucnctionsProvider>(context,
                                          listen: false)
                                      .deleteFAvorite(
                                          widget.songModelList[currentindex].id,
                                          context);
                                  fav = false;
                                } else {
                                  Provider.of<DbFucnctionsProvider>(context,
                                          listen: false)
                                      .addToFavorites(
                                          widget.songModelList[currentindex].id,
                                          context);
                                  fav = true;
                                }
                                getsong();
                              },
                              icon: fav
                                  ? const Icon(
                                      Icons.favorite,
                                      color: Colors.red,
                                    )
                                  : const Icon(
                                      Icons.favorite,
                                      color: Color.fromARGB(255, 247, 247, 247),
                                    ))
                        ],
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        position.toString().substring(2, 7),
                        style: const TextStyle(color: Colors.white),
                      ),
                      Expanded(
                          child: SliderTheme(
                              data: SliderTheme.of(context).copyWith(
                                  activeTrackColor:
                                      const Color.fromARGB(255, 0, 58, 105),
                                  thumbShape: const RoundSliderThumbShape(
                                      enabledThumbRadius: 8),
                                  overlayShape: const RoundSliderOverlayShape(
                                      overlayRadius: 2),
                                  trackHeight: 3),
                              child: Slider(
                                value: position.inSeconds.toDouble(),
                                onChanged: ((value) {
                                  setState(() {
                                    changeToSeconds(value.toInt());
                                    value = value;
                                  });
                                }),
                                min: 0.0,
                                max: duration.inSeconds.toDouble(),
                                inactiveColor: Colors.white,
                                activeColor:
                                    const Color.fromARGB(255, 15, 159, 167),
                              ))),
                      Text(
                        duration.toString().substring(2, 7),
                        style: const TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * .04),
                  Container(
                    transformAlignment: Alignment.center,
                    height: 70,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.white),
                        borderRadius: BorderRadius.circular(20)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Align(
                          alignment: Alignment.topCenter,
                          child: IconButton(
                              onPressed: () async {
                                if (GetAllSong.axplayer.hasPrevious) {
                                  Provider.of<DbFucnctionsProvider>(context,
                                          listen: false)
                                      .addtorecent(GetAllSong
                                          .playingSong[GetAllSong
                                                  .axplayer.currentIndex! -
                                              1]
                                          .id);
                                  Provider.of<DbFucnctionsProvider>(context,
                                          listen: false)
                                      .addToMostplayed(GetAllSong
                                          .playingSong[GetAllSong
                                                  .axplayer.currentIndex! -
                                              1]
                                          .id);
                                  await GetAllSong.axplayer.seekToPrevious();
                                  await GetAllSong.axplayer.play();
                                } else {
                                  GetAllSong.axplayer.play();
                                }
                              },
                              icon: const Icon(Icons.skip_previous, size: 60)),
                        ),
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blue,
                                shape: const CircleBorder()),
                            onPressed: () async {
                              if (GetAllSong.axplayer.playing) {
                                await GetAllSong.axplayer.pause();
                              } else {
                                GetAllSong.axplayer.play();
                                setState(() {});
                              }
                            },
                            child: Icon(
                                GetAllSong.axplayer.playing
                                    ? Icons.pause
                                    : Icons.play_arrow,
                                size: 70)),
                        Align(
                          alignment: Alignment.topCenter,
                          child: IconButton(
                              onPressed: () async {
                                if (GetAllSong.axplayer.hasNext) {
                                  Provider.of<DbFucnctionsProvider>(context,
                                          listen: false)
                                      .addtorecent(GetAllSong
                                          .playingSong[GetAllSong
                                                  .axplayer.currentIndex! +
                                              1]
                                          .id);
                                  Provider.of<DbFucnctionsProvider>(context,
                                          listen: false)
                                      .addToMostplayed(GetAllSong
                                          .playingSong[GetAllSong
                                                  .axplayer.currentIndex! +
                                              1]
                                          .id);
                                  await GetAllSong.axplayer.seekToNext();
                                  await GetAllSong.axplayer.play();
                                } else {
                                  GetAllSong.axplayer.play();
                                }
                              },
                              icon: const Icon(
                                Icons.skip_next,
                                size: 60,
                              )),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      )),
    );
  }

  void changeToSeconds(int seconds) {
    Duration duration = Duration(seconds: seconds);
    GetAllSong.axplayer.seek(duration);
  }

  void playSong() {
    GetAllSong.axplayer.durationStream.listen((event) {
      setState(() {
        duration = event!;
      });
    });
    GetAllSong.axplayer.positionStream.listen((event) {
      setState(() {
        position = event;
      });
    });
  }
}
