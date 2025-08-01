import 'package:talker/talker.dart';

base class LoggerEngine {
  static final _talker = Talker();

  static void debug(String message) => _talker.debug(message);

  static void info(String message) => _talker.info(message);

  static void warning(String message) => _talker.warning(message);

  static void error(String message, [dynamic error]) =>
      _talker.error(message, error, StackTrace.current);
}
