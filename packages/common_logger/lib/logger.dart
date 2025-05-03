import 'logger_engine.dart';

mixin Logger {
  void debug(String message) {
    LoggerEngine.debug(message);
  }

  void error(String message) {
    LoggerEngine.error(message);
  }

  void info(String message) {
    LoggerEngine.info(message);
  }

  void warning(String message) {
    LoggerEngine.warning(message);
  }
}
