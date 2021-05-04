@TestOn('vm')
import 'package:dart_code_metrics/src/analyzers/lint_analyzer/metrics_analysis_runner.dart';
import 'package:dart_code_metrics/src/analyzers/lint_analyzer/metrics_analyzer.dart';
import 'package:dart_code_metrics/src/analyzers/lint_analyzer/metrics_records_store.dart';
import 'package:dart_code_metrics/src/analyzers/models/file_report.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

// ignore: deprecated_member_use_from_same_package
class MetricsRecordsStoreMock extends Mock implements MetricsRecordsStore {}

// ignore: deprecated_member_use_from_same_package
class MetricsAnalyzerMock extends Mock implements MetricsAnalyzer {}

void main() {
  group('MetricsAnalysisRunner', () {
    test('results() returns array of FileRecords', () {
      const stubRecords = [
        FileReport(
          path: 'lib/foo.dart',
          relativePath: 'foo.dart',
          classes: {},
          functions: {},
          issues: [],
          antiPatternCases: [],
        ),
        FileReport(
          path: 'lib/bar.dart',
          relativePath: 'bar.dart',
          classes: {},
          functions: {},
          issues: [],
          antiPatternCases: [],
        ),
      ];

      final store = MetricsRecordsStoreMock();
      when(store.records).thenReturn(stubRecords);

      final runner =
          // ignore: deprecated_member_use_from_same_package
          MetricsAnalysisRunner(MetricsAnalyzerMock(), store, const [], '');

      expect(runner.results(), equals(stubRecords));
    });

    test('run() calls MetricsAnalyzer.runAnalysis for every file paths', () {
      const folders = ['lib', 'test'];
      const root = '/home/developer/project/';

      final analyzer = MetricsAnalyzerMock();
      when(() => analyzer.runAnalysis(folders, root))
          .thenAnswer((_) async => print('called'));

      // ignore: deprecated_member_use_from_same_package
      MetricsAnalysisRunner(analyzer, MetricsRecordsStoreMock(), folders, root)
          .run();

      verify(() => analyzer.runAnalysis(folders, root));
      verifyNoMoreInteractions(analyzer);
    });
  });
}
