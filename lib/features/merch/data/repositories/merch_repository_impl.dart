import 'package:merchok/features/merch/merch.dart';

class MerchRepositoryImpl implements MerchRepository {
  final Map<String, Merch> merchList = {};

  @override
  Future<List<Merch>> getMerches() async => merchList.values.toList();

  @override
  Future<void> editMerch(Merch merch) async =>
      merchList.addAll({merch.id: merch});

  @override
  Future<void> deleteMerch(String merchId) async => merchList.remove(merchId);
}
