import 'package:data_network/model/data_response_network_model.dart';
import 'package:domain_repository/entity/data_response_entity.dart';

extension DataResponseNetworkMapper<T> on DataResponseNetworkModel<T> {
  DataResponseEntity<R> toEntity<R>(R Function(T model) mapper) {
    return DataResponseEntity(
      timestamp: timestamp,
      data: mapper(data)
    );
  }
}
