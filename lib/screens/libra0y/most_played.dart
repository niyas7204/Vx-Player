import 'dart:developer';

import 'package:audio_player_final/fuctions/getall_song.dart';
import 'package:audio_player_final/provider/get_library_provider.dart';
import 'package:audio_player_final/screens/mini_player.dart';
import 'package:audio_player_final/widgets/common_widgets.dart';
import 'package:flutter/material.dart';

import 'package:audio_player_final/fuctions/database_functions.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:on_audio_query/on_audio_query.dart';

import 'package:provider/provider.dart';

class MostplayedSc extends StatelessWidget {
  const MostplayedSc({super.key});

  @override
  Widget build(BuildContext context) {
    Provider.of<GetlibarahSongProvider>(context).orderMostPlayed(context);
    return Scaffold(
        backgroundColor: const Color.fromARGB(120, 0, 0, 0),
        appBar: AppBar(
          title: cText('Most Played'),
        ),
        body: SafeArea(
          child: Consumer<GetlibarahSongProvider>(
            builder: (context, value, child) => Padding(
                padding: const EdgeInsets.all(10),
                child: Builder(
                  builder: (context) {
                    if (value.mostSongs.isEmpty) {
                      return Center(child: emptyText('No Songs Found'));
                    } else {
                      return ListView.separated(
                          itemBuilder: (context, index) {
                            return songlist(value.mostSongs, index, context);
                          },
                          separatorBuilder: (context, index) => const SizedBox(
                                height: 10,
                              ),
                          itemCount: value.mostSongs.length);
                    }
                  },
                )),
          ),
        ),
        bottomNavigationBar: const MiniPlayer());
  }
}
