import 'package:data_network/model/history_response_network_model.dart';
import 'package:domain_repository/entity/history_entity.dart';

extension HistoryNetworkMapper on HistoryResponseNetworkModel {
  HistoryEntity toEntity() {
    return HistoryEntity(priceUsd: priceUsd, time: time, date: date);
  }
}
