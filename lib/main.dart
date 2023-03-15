import 'dart:async';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:audio_player_final/db/playlist_model.dart';
import 'package:audio_player_final/screens/main_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized;
  if (!Hive.isAdapterRegistered(PlayListMOdelAdapter().typeId)) {
    Hive.registerAdapter(PlayListMOdelAdapter());
  }
  await Hive.initFlutter();
  await Hive.openBox<PlayListMOdel>('playlist_Data');
  await Hive.openBox<int>('favorite_songs');
  await Hive.openBox<int>('recentlyPlayed');
  await Hive.openBox('MostPlayed');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MainScreen(),
    );
  }
}
