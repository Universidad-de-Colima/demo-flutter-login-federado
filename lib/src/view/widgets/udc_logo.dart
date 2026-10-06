part of 'widgets_library.dart';

/// Determinate the size of the widget [child] based on the screen size
///
/// This widget is used to constrain the logo widget
class LogoConstraints extends StatelessWidget {
  /// Determinate the size of the widget [child] based on the screen size
  const LogoConstraints({
    required this.child,
    super.key,
  });

  /// Widget to be constrained and displayed as logo
  final Widget child;

  @override
  Widget build(BuildContext context) {
    // Based on the shortest side (and capped) so the logo doesn't blow up on
    // tablets or when the device rotates to landscape.
    final shortest = MediaQuery.sizeOf(context).shortestSide;
    final maxSize = (0.8 * shortest).clamp(160.0, 320.0);
    final minSize = min(200.0, maxSize);
    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minWidth: minSize,
          maxWidth: maxSize,
        ),
        child: child,
      ),
    );
  }
}

/// Widget to be displayed as logo by default
class UdcLogo extends StatelessWidget {
  /// Widget to be displayed as logo by default
  const UdcLogo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      UdcAssets.defaultIcon,
    );
  }
}
