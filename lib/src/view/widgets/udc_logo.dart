part of widgets;

/// Determinate the size of the widget [child] based on the screen size
///
/// This widget is used to constrain the logo widget
class LogoConstraints extends StatelessWidget {
  /// Determinate the size of the widget [child] based on the screen size
  const LogoConstraints({
    super.key,
    required this.child,
  });

  /// Widget to be constrained and displayed as logo
  final Widget child;

  @override
  Widget build(BuildContext context) {
    const expectedSize = 200.0;
    final screenSize = 0.8 * MediaQuery.of(context).size.width;
    final minSize = min(expectedSize, screenSize);
    final maxSize = max(expectedSize, screenSize);
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
    return const Image(
      image: UdcAssets.defaultIcon,
    );
  }
}
