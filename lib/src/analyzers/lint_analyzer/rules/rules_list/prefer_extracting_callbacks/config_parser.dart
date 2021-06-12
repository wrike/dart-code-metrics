part of 'prefer_extracting_callbacks.dart';

class _ConfigParser {
  static const _ignoredArgumentsConfig = 'ignored-arguments';

  static Iterable<String> parseIgnoredArguments(Map<String, Object> config) =>
      config.containsKey(_ignoredArgumentsConfig) &&
              config[_ignoredArgumentsConfig] is Iterable
          ? List<String>.from(config[_ignoredArgumentsConfig] as Iterable)
          : <String>[];
}
