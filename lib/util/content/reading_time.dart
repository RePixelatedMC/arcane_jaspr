/// Result of reading time calculation.
class ReadingTimeResult {
  /// Estimated reading time in minutes.
  final int minutes;

  /// Total word count.
  final int wordCount;

  /// Human-readable reading time string.
  String get text => '$minutes min read';

  const ReadingTimeResult({
    required this.minutes,
    required this.wordCount,
  });

  @override
  String toString() => text;
}

/// Calculate reading time for markdown or plain text content.
///
/// Strips common markdown formatting for more accurate word count.
/// Returns minimum 1 minute for any non-empty content.
///
/// Example:
/// ```dart
/// final result = calculateReadingTime(markdownContent);
/// print('${result.minutes} min read (${result.wordCount} words)');
/// ```
ReadingTimeResult calculateReadingTime(
  String content, {
  int wordsPerMinute = 200,
}) {
  String text = content;

  // Remove frontmatter
  if (text.startsWith('---')) {
    final int endIndex = text.indexOf('---', 3);
    if (endIndex > 0) {
      text = text.substring(endIndex + 3);
    }
  }

  // Remove markdown formatting for more accurate word count
  text = text
      // Remove code blocks
      .replaceAll(RegExp(r'```[\s\S]*?```'), '')
      // Remove inline code
      .replaceAll(RegExp(r'`[^`]+`'), '')
      // Remove images
      .replaceAll(RegExp(r'!\[.*?\]\(.*?\)'), '')
      // Remove links (keep text)
      .replaceAll(RegExp(r'\[([^\]]+)\]\([^)]+\)'), r'$1')
      // Remove headers markers
      .replaceAll(RegExp(r'^#+\s*', multiLine: true), '')
      // Remove bold/italic markers
      .replaceAll(RegExp(r'[*_]{1,2}([^*_]+)[*_]{1,2}'), r'$1')
      // Remove HTML tags
      .replaceAll(RegExp(r'<[^>]+>'), '');

  // Count words
  final List<String> words =
      text.split(RegExp(r'\s+')).where((String w) => w.isNotEmpty).toList();
  final int wordCount = words.length;

  // Calculate reading time (minimum 1 minute)
  final int readingTime = (wordCount / wordsPerMinute).ceil();
  final int finalTime = readingTime < 1 ? 1 : readingTime;

  return ReadingTimeResult(
    minutes: finalTime,
    wordCount: wordCount,
  );
}

/// Extension for calculating reading time from strings.
extension ReadingTimeExtension on String {
  /// Calculate reading time for this string.
  ReadingTimeResult get readingTime => calculateReadingTime(this);

  /// Calculate reading time with custom words per minute.
  ReadingTimeResult readingTimeWithSpeed(int wordsPerMinute) =>
      calculateReadingTime(this, wordsPerMinute: wordsPerMinute);
}
