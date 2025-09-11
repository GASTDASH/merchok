import 'package:merchok/features/festival/festival.dart';

abstract interface class FestivalRepository {
  Future<List<Festival>> getFestivals();
  Future<void> editFestival(Festival festival);
  Future<void> deleteFestival(String festivalId);
  Future<void> saveSelectedFestival(Festival festival);
}
