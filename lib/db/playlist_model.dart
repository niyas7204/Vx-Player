import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive/hive.dart';
part 'playlist_model.g.dart';

@HiveType(typeId: 1)
class PlayListMOdel {
  @HiveField(0)
  String listName;
  @HiveField(1)
  List<int> songId;
  PlayListMOdel({required this.listName, required this.songId});
}
