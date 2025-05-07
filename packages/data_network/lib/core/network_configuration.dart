import 'package:flutter_dotenv/flutter_dotenv.dart';

class NetworkConfiguration {
  static String get apiKey => dotenv.env['API_KEY'] ?? 'NO_KEY';

  static String get baseUrl => dotenv.env['BASE_URL'] ?? 'NO_URL';

  static const Duration connectTimeout = Duration(seconds: 30);
}
