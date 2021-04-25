@TestOn('vm')
import 'package:dart_code_metrics/src/models/severity.dart';
import 'package:dart_code_metrics/src/obsoleted/rules/no_equal_arguments.dart';
import 'package:test/test.dart';

import '../../../helpers/rule_test_helper.dart';

// ignore_for_file: no_adjacent_strings_in_list

const _examplePath =
    'test/obsoleted/rules/no_equal_arguments/examples/example.dart';
const _incorrectExamplePath =
    'test/obsoleted/rules/no_equal_arguments/examples/incorrect_example.dart';

void main() {
  group('NoEqualArguments', () {
    test('initialization', () async {
      final unit = await RuleTestHelper.resolveFromFile(_examplePath);
      final issues = NoEqualArguments().check(unit);

      RuleTestHelper.verifyInitialization(
        issues: issues,
        ruleId: 'no-equal-arguments',
        severity: Severity.warning,
      );
    });

    test('reports about found issues', () async {
      final unit = await RuleTestHelper.resolveFromFile(_incorrectExamplePath);
      final issues = NoEqualArguments().check(unit);

      RuleTestHelper.verifyIssues(
        issues: issues,
        startOffsets: [328, 669, 753, 842, 942, 1068, 1170],
        startLines: [17, 32, 37, 42, 47, 54, 59],
        startColumns: [5, 5, 5, 5, 5, 5, 5],
        endOffsets: [337, 683, 765, 861, 965, 1089, 1194],
        locationTexts: [
          'firstName',
          'user.firstName',
          'user.getName',
          'user.getFirstName()',
          "user.getNewName('name')",
          'user.getNewName(name)',
          'lastName: user.firstName',
        ],
        messages: [
          'The argument has already been passed',
          'The argument has already been passed',
          'The argument has already been passed',
          'The argument has already been passed',
          'The argument has already been passed',
          'The argument has already been passed',
          'The argument has already been passed',
        ],
      );
    });

    test('reports no issues', () async {
      final unit = await RuleTestHelper.resolveFromFile(_examplePath);
      final issues = NoEqualArguments().check(unit);

      RuleTestHelper.verifyNoIssues(issues);
    });
  });
}