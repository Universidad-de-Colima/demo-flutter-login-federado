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
    final shortest = MediaQuery.sizeOf(context).shortestSide;
    final maxSize = (0.7 * shortest).clamp(160.0, 300.0);
    final minSize = min(200.0, maxSize);
    return ConstrainedBox(
      constraints: BoxConstraints(
        minWidth: minSize,
        maxWidth: maxSize,
      ),
      child: title,
    );
  }
}

/// Scale factor for fixed font sizes: 1.0 on phones, growing up to 1.6 on
/// tablets (based on the shortest side so rotating doesn't change it).
double adaptiveTextScale(BuildContext context) {
  final shortest = MediaQuery.sizeOf(context).shortestSide;
  return (shortest / 400).clamp(1.0, 1.6);
}
