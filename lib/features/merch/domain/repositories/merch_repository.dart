import 'package:merchok/features/merch/merch.dart';

abstract interface class MerchRepository {
  Future<List<Merch>> getMerches();
  Future<void> saveMerch(Merch merch);
  Future<void> deleteMerch(String merchId);
}
