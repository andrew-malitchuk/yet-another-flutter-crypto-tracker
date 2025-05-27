import 'base/base_entity.dart';

class HistoryEntity extends BaseEntity {
  final String priceUsd;
  final int time;
  final String date;

  HistoryEntity({
    required this.priceUsd,
    required this.time,
    required this.date,
  });
}
