part of 'widgets_library.dart';

/// Determinate the size of the widget [title] based on the screen size
class TitleConstraints extends StatelessWidget {
  /// Determinate the size of the widget [title] based on the screen size
  const TitleConstraints({
    required this.title,
    super.key,
  });

  /// Widget to be constrained and displayed as title
  final Widget title;
  @override
  Widget build(BuildContext context) {
    const expectedSize = 200.0;
    final screenSize = 0.7 * MediaQuery.of(context).size.width;
    final minSize = min(expectedSize, screenSize);
    final maxSize = max(expectedSize, screenSize);
    return ConstrainedBox(
      constraints: BoxConstraints(
        minWidth: minSize,
        maxWidth: maxSize,
      ),
      child: title,
    );
  }
}
