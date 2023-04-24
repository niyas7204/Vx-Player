import 'dart:async';
import 'package:audio_player_final/fuctions/database_functions.dart';
import 'package:audio_player_final/provider/audio_provider.dart';
import 'package:audio_player_final/provider/get_library_provider.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:audio_player_final/db/playlist_model.dart';
import 'package:audio_player_final/screens/main_screen.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized;
  if (!Hive.isAdapterRegistered(PlayListMOdelAdapter().typeId)) {
    Hive.registerAdapter(PlayListMOdelAdapter());
  }
  await Hive.initFlutter();
  await Hive.openBox<PlayListMOdel>('playlist_Data');
  await Hive.openBox('favorite_songs');
  await Hive.openBox('recentlyPlayed');
  await Hive.openBox('MostPlayed');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => GetlibarahSongProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => AudioQuaryProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => DbFucnctionsProvider(),
        )
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: MainScreen(),
      ),
    );
  }
}
