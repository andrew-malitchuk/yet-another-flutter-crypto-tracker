import 'package:dio/dio.dart';
import 'package:provider/provider.dart';

import '../core/network_client.dart';
import '../service/api_service.dart';
import '../source/api_source.dart';

/// A list of providers for dependency injection of network-related classes.
///
/// - `NetworkClient`: Handles low-level network operations.
/// - `ApiService`: Provides API methods, depends on `NetworkClient`.
/// - `ApiSource`: Data source that uses `ApiService` for network requests.
List<Provider> dataNetworkProviders = [
  /// Provides a singleton instance of [NetworkClient].
  Provider<NetworkClient>(
    create: (_) => NetworkClient(),
  ),
  /// Provides an [ApiService] that depends on [NetworkClient].
  Provider<ApiService>(
    create: (context) => ApiService(context.read<NetworkClient>()),
  ),
  /// Provides an [ApiSource] that depends on [ApiService].
  Provider<ApiSource>(
    create: (context) => ApiSource(context.read<ApiService>()),
  ),
];