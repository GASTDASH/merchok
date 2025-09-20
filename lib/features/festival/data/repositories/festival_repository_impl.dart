import 'package:hive/hive.dart';
import 'package:merchok/core/core.dart';
import 'package:merchok/features/festival/festival.dart';

class FestivalRepositoryImpl implements FestivalRepository {
  final Box<Festival> festivalBox = Hive.box(HiveBoxesNames.festivals);

  @override
  Future<void> deleteFestival(String festivalId) async =>
      await festivalBox.delete(festivalId);

  @override
  Future<void> editFestival(Festival festival) async =>
      await festivalBox.put(festival.id, festival);

  @override
  Future<List<Festival>> getFestivals() async => festivalBox.values.toList();
}
