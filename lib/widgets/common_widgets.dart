import 'package:audio_player_final/fuctions/database_functions.dart';
import 'package:audio_player_final/fuctions/getall_song.dart';
import 'package:audio_player_final/screens/library/playt_list/addtoplaylist.dart';
import 'package:audio_player_final/screens/playing_screen.dart';
import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';

liberyCard(cardName, context, page) {
  return Row(
    children: [
      Column(
        children: [
          GestureDetector(
            onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => page,
                )),
            child: Container(
              alignment: Alignment.center,
              height: MediaQuery.of(context).size.height * .15,
              width: MediaQuery.of(context).size.width * .36,
              decoration: BoxDecoration(
                image: const DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage(
                        'assets/images/apps.33844.9007199266251864.cae5b893-a71b-40d7-abde-a6e8e23675c3.png')),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: 55,
                  width: MediaQuery.of(context).size.width * .36,
                  color: const Color.fromARGB(136, 0, 0, 0),
                  child: Align(
                    alignment: Alignment.center,
                    child: cText(cardName),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          )
        ],
      ),
      const SizedBox(
        width: 10,
      )
    ],
  );
}

cText(text) {
  return Text(
    text,
    style: const TextStyle(
        fontSize: 23, color: Color.fromARGB(255, 255, 255, 255)),
  );
}

popmoreDiologe(SongModel songData) {
  return PopupMenuButton(
    icon: const Icon(
      Icons.more_vert,
      color: Colors.white,
    ),
    itemBuilder: (context) => [
      PopupMenuItem(
          child: GestureDetector(
        onTap: () {
          Navigator.of(context).pop();
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => AddToPlaylist(allSong: songData),
          ));
        },
        child: Row(
          children: const [Text('Add to playlist'), Icon(Icons.add)],
        ),
      )),
      PopupMenuItem(child: Builder(
        builder: (context) {
          final bool fav = chekFavorite(songData.id);
          if (!fav) {
            return GestureDetector(
              onTap: () {
                addToFavorites(songData.id, context);
                Navigator.of(context).pop();
              },
              child: Row(
                children: const [
                  Text('Add to favorite'),
                  Icon(Icons.favorite_sharp)
                ],
              ),
            );
          } else {
            return GestureDetector(
              onTap: () {
                deleteFAvorite(songData.id, context);
                Navigator.of(context).pop();
              },
              child: Row(
                children: const [
                  Text('delete from favorite'),
                  Icon(Icons.favorite_sharp)
                ],
              ),
            );
          }
        },
      ))
    ],
  );
}

songlist(List<SongModel> songDAta, index, context) {
  return Container(
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: const Color.fromARGB(88, 90, 169, 233)),
    child: ListTile(
      onTap: () async {
        addToMostplayed(songDAta[index].id);
        addtorecent(songDAta[index].id);

        await GetAllSong.axplayer.setAudioSource(
            GetAllSong.createSonglist(songDAta),
            initialIndex: index);

        GetAllSong.axplayer.play();
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PlayerSc(
                songModelList: songDAta,
              ),
            ));
      },
      leading: const Icon(
        Icons.music_note,
        color: Colors.white,
        size: 40,
      ),
      title: Text(
        songDAta[index].displayName,
        style: const TextStyle(color: Colors.white),
        maxLines: 1,
      ),
      subtitle: Text(
        songDAta[index].displayName,
        style: const TextStyle(color: Colors.white),
        maxLines: 1,
      ),
      trailing: popmoreDiologe(songDAta[index]),
    ),
  );
}

emptyText(text) {
  return Align(
    alignment: Alignment.center,
    child: Text(
      text,
      style: const TextStyle(color: Colors.white, fontSize: 30),
    ),
  );
}