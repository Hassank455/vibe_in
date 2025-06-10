import 'package:logger/logger.dart';

class AppLogger {
  static final Logger _logger = Logger(
    printer: PrettyPrinter(
      methodCount: 0,
      colors: true,
      printEmojis: true,
      lineLength: 50,
      errorMethodCount: 3,
      levelColors: {
        Level.debug: AnsiColor.fg(8),
        Level.info: AnsiColor.fg(10),
        Level.warning: AnsiColor.fg(214),
        Level.error: AnsiColor.fg(196),
        Level.fatal: AnsiColor.fg(199),
      },
    ),
  );

  /// Logs a debug message (only in debug mode)
  static void debug(dynamic message) => _logger.d(message);

  /// Logs a regular info message
  static void info(dynamic message) => _logger.i(message);

  /// Logs a warning
  static void warning(dynamic message) => _logger.w(message);

  /// Logs an error with optional exception and stack trace
  static void error(dynamic message, {dynamic error, StackTrace? stackTrace}) =>
      _logger.e(message, error: error, stackTrace: stackTrace);

  /// Logs a WTF (What a Terrible Failure) message — for unrecoverable situations
  static void fatal(dynamic message) => _logger.f(message);
}
