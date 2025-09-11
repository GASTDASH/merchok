import 'package:merchok/features/festival/festival.dart';

class FestivalRepositoryImpl implements FestivalRepository {
  final Map<String, Festival> festivalList = {};

  @override
  Future<List<Festival>> getFestivals() async => festivalList.values.toList();

  @override
  Future<void> editFestival(Festival festival) async =>
      festivalList.addAll({festival.id: festival});

  @override
  Future<void> deleteFestival(String festivalId) async =>
      festivalList.remove(festivalId);
}
