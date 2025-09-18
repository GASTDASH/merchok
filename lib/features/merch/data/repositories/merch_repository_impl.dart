import 'package:hive/hive.dart';
import 'package:merchok/core/core.dart';
import 'package:merchok/features/merch/merch.dart';

class MerchRepositoryImpl implements MerchRepository {
  final Box<Merch> merchBox = Hive.box(HiveBoxesNames.merches);

  @override
  Future<List<Merch>> getMerches() async => merchBox.values.toList();

  @override
  Future<void> editMerch(Merch merch) async =>
      await merchBox.put(merch.id, merch);

  @override
  Future<void> deleteMerch(String merchId) async =>
      await merchBox.delete(merchId);
}
