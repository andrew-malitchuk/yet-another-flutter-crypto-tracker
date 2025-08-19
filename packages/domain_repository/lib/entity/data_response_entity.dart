import 'package:domain_repository/entity/base/base_entity.dart';

class DataResponseEntity<T> extends BaseEntity {
  final int timestamp;
  final T data;

  DataResponseEntity({required this.timestamp, required this.data});

  @override
  List<Object?> get props => [timestamp, data];
}
