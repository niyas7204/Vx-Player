import 'package:audio_player_final/widgets/common_widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:on_audio_query/on_audio_query.dart';

class SearchSCreen extends StatefulWidget {
  const SearchSCreen({super.key});

  @override
  State<SearchSCreen> createState() => _SearchSCreenState();
}

class _SearchSCreenState extends State<SearchSCreen> {
  List<SongModel> allsong = [];
  bool searchState = false;
  List<SongModel> foundsongs = [];
  final audioQuery = OnAudioQuery();
  late bool fav;

  @override
  void initState() {
    setState(() {
      loadSong();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: CupertinoSearchTextField(
          borderRadius: const BorderRadius.all(Radius.circular(20)),
          prefixIcon: const Icon(Icons.search),
          backgroundColor: Colors.white,
          onChanged: (value) => search(value),
        ),
      ),
      body: SafeArea(
        child: Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage(
                      'assets/images/HD-wallpaper-music-notes-thumbnail.jpg'))),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Builder(
              builder: (context) {
                if (searchState) {
                  if (foundsongs.isEmpty) {
                    return Center(child: cText('No Result Found'));
                  } else {
                    return ListView.separated(
                        itemBuilder: (context, index) {
                          return songlist(foundsongs, index, context);
                        },
                        separatorBuilder: (context, index) => const SizedBox(
                              height: 10,
                            ),
                        itemCount: foundsongs.length);
                  }
                } else {
                  return ListView.separated(
                      itemBuilder: (context, index) {
                        return songlist(allsong, index, context);
                      },
                      separatorBuilder: (context, index) => const SizedBox(
                            height: 10,
                          ),
                      itemCount: allsong.length);
                }
              },
            ),
          ),
        ),
      ),
    );
  }

  loadSong() async {
    allsong = await audioQuery.querySongs(
      sortType: null,
      orderType: OrderType.ASC_OR_SMALLER,
      uriType: UriType.EXTERNAL,
      ignoreCase: true,
    );
  }

  void search(String enterdKEY) {
    searchState = true;
    final key = enterdKEY.trim();
    List<SongModel> result = [];
    if (key.isEmpty) {
      result = allsong;
    } else {
      result = allsong
          .where((element) => element.title.toLowerCase().contains(key))
          .toList();
    }
    setState(() {
      foundsongs = result;
    });
  }
}
