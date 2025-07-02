import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';

class AppLogger {
  static final Logger _logger = Logger(
    level: kReleaseMode ? Level.warning : Level.trace,
    printer: PrettyPrinter(
      methodCount: 0,
      colors: true,
      printEmojis: true,
      lineLength: 50,
      errorMethodCount: 3,
      levelColors: {
        Level.trace: AnsiColor.fg(7),
        Level.debug: AnsiColor.fg(8),
        Level.info: AnsiColor.fg(10),
        Level.warning: AnsiColor.fg(214),
        Level.error: AnsiColor.fg(196),
        Level.fatal: AnsiColor.fg(199),
      },
    ),
  );

  /// TRACE (Verbose)
  /// Use this for very detailed logs, like API responses, loop iterations, or deep debugging.
  /// This level is usually disabled in production.
  /// Example: AppLogger.verbose('Parsing JSON body: $jsonBody');
  static void verbose(dynamic message) => _logger.t('[VERBOSE] $message');

  /// DEBUG
  /// Use this to track application flow and variable states.
  /// Great for confirming that methods are being called as expected.
  /// Example: AppLogger.debug('Entered login() method');
  static void debug(dynamic message) => _logger.d('[DEBUG] $message');

  /// INFO
  /// Use this to log meaningful events that happen during normal app operation.
  /// Example: AppLogger.info('User successfully logged in');
  static void info(dynamic message) => _logger.i('[INFO] $message');

  /// WARNING
  /// Use this to indicate something unexpected that didn’t cause a failure,
  /// but might become a problem later.
  /// Example: AppLogger.warning('Missing profile image — using default avatar');
  static void warning(dynamic message) => _logger.w('[WARNING] $message');

  /// ERROR
  /// Use this when something has gone wrong that needs attention.
  /// You can optionally include the exception and stack trace for debugging.
  /// Example: AppLogger.error('Failed to load data', error: e, stackTrace: s);
  static void error(dynamic message, {dynamic error, StackTrace? stackTrace}) =>
      _logger.e('[ERROR] $message', error: error, stackTrace: stackTrace);

  /// FATAL
  /// Use this for unrecoverable errors — things that should never happen
  /// and may require app shutdown or crash reporting.
  /// Example: AppLogger.fatal('Database connection failed — aborting startup');
  static void fatal(dynamic message) => _logger.f('[FATAL] $message');
}
