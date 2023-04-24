import 'package:audio_player_final/provider/get_library_provider.dart';
import 'package:audio_player_final/screens/mini_player.dart';
import 'package:audio_player_final/widgets/common_widgets.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

class RecentlyPlayed extends StatelessWidget {
  const RecentlyPlayed({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(120, 0, 0, 0),
        appBar: AppBar(
            title: Row(
          children: const [
            Text('RecentPlaylist'),
            Icon(Icons.replay_circle_filled_outlined)
          ],
        )),
        body:
            Consumer<GetlibarahSongProvider>(builder: (context, value, child) {
          value.getrecentSongs(context);
          return Padding(
              padding: const EdgeInsets.all(10),
              child: Builder(
                builder: (context) {
                  if (value.recentSongs.isEmpty) {
                    return Padding(
                      padding: const EdgeInsets.only(top: 70, left: 10),
                      child: Center(
                        child: emptyText('No recent songs'),
                      ),
                    );
                  } else {
                    return ListView.separated(
                        itemBuilder: (context, index) =>
                            songlist(value.recentSongs, index, context),
                        separatorBuilder: (context, index) => const SizedBox(
                              height: 10,
                            ),
                        itemCount: value.recentSongs.length);
                  }
                },
              ));
        }),
        bottomNavigationBar: const MiniPlayer());
  }
}
