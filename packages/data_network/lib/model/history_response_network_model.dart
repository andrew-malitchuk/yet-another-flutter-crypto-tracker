import 'package:data_network/model/base/base_network_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'history_response_network_model.g.dart';

/// Represents a historical price response model for network operations.
///
/// JSON example:
///
/// ```json
/// {
///   "priceUsd": "57006.4814312680237124",
///   "time": 1725915600000,
///   "date": "2024-09-09T21:00:00.000Z"
/// }
/// ```
@JsonSerializable()
class HistoryResponseNetworkModel extends BaseNetworkModel {
  @JsonKey(name: 'priceUsd')
  final String priceUsd;
  @JsonKey(name: 'time')
  final int time;
  @JsonKey(name: 'date')
  final String date;

  HistoryResponseNetworkModel({
    required this.priceUsd,
    required this.time,
    required this.date,
  });

// todo wtf
  factory HistoryResponseNetworkModel.fromJson(Map<String, dynamic> json) =>
      _$HistoryResponseNetworkModelFromJson(json);

// todo wtf
  Map<String, dynamic> toJson() => _$HistoryResponseNetworkModelToJson(this);
}