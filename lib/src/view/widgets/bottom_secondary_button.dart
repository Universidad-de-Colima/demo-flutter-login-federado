part of 'widgets_library.dart';

/// Styled button to place in bottom of screen
class BottomSecondaryButton extends StatelessWidget {
  /// Styled button to place in bottom of screen
  const BottomSecondaryButton({
    required this.onPressed,
    required this.text,
    this.authButton,
    this.buttonIcon,
    this.buttonStyle,
    this.copyrightPeriod,
    this.sidePanel = false,
    super.key,
  });

  /// Whether the panel is displayed at the side of the screen (landscape)
  /// instead of at the bottom. The parent is then in charge of the rounded
  /// corners and the panel fills the available height.
  final bool sidePanel;

  /// Callback to be called when the button is pressed
  final VoidCallback onPressed;

  /// Text to be displayed in the button
  final String text;

  /// If are implementing a method to retake the session, pass the widget
  /// to be displayed in the bottom of the screen
  final Widget? authButton;

  /// Optional icon displayed inside the login button
  final Widget? buttonIcon;

  /// Optional style applied to the login button; merged on top of the default
  final ButtonStyle? buttonStyle;

  /// Copyright period, e.g. '2022 - 2026'. Defaults to '2022 - 2025' if null.
  final String? copyrightPeriod;

  Widget _button() => _ButtonWrapper(
        onPressed: onPressed,
        text: text,
        icon: buttonIcon,
        style: buttonStyle,
      );

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: sidePanel ? double.infinity : null,
      decoration: BoxDecoration(
        color: UdcColors.actionSecondary,
        borderRadius: sidePanel
            ? null
            : const BorderRadius.vertical(top: Radius.circular(72)),
      ),
      child: Column(
        mainAxisSize: sidePanel ? MainAxisSize.max : MainAxisSize.min,
        children: [
          if (sidePanel)
            Expanded(child: Center(child: _button()))
          else
            Padding(
              padding: const EdgeInsets.only(top: 40),
              child: _button(),
            ),
          if (authButton != null) authButton!,
          _Disclaimer(copyrightPeriod: copyrightPeriod),
        ],
      ),
    );
  }
}

class _ButtonWrapper extends StatelessWidget {
  const _ButtonWrapper({
    required this.onPressed,
    required this.text,
    this.icon,
    this.style,
  });
  final VoidCallback onPressed;
  final String text;
  final Widget? icon;
  final ButtonStyle? style;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final verticalPad = (size.height * 0.018).clamp(8.0, 15.0);
    final defaultStyle = TextButton.styleFrom(
      backgroundColor: Colors.white,
      padding: EdgeInsets.symmetric(
        horizontal: (size.width * 0.1).clamp(24.0, 56.0),
        vertical: verticalPad,
      ),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(100),
        ),
      ),
    );
    return TextButton(
      onPressed: onPressed,
      style: style != null ? defaultStyle.merge(style) : defaultStyle,
      // Scales the content down instead of overflowing in narrow windows
      child: FittedBox(
        fit: BoxFit.scaleDown,
        child: icon != null
            ? Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  icon!,
                  const SizedBox(width: 8),
                  _ButtonText(text: text),
                ],
              )
            : _ButtonText(text: text),
      ),
    );
  }
}

class _ButtonText extends StatelessWidget {
  const _ButtonText({
    required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    final fontSize =
        (MediaQuery.sizeOf(context).shortestSide * 0.05).clamp(14.0, 28.0);
    return Text(
      text,
      style: TextStyle(
        fontSize: fontSize,
        fontWeight: FontWeight.w500,
        height: 1.1,
        color: UdcColors.textPrimary,
      ),
    );
  }
}

class _Disclaimer extends StatelessWidget {
  const _Disclaimer({this.copyrightPeriod});

  final String? copyrightPeriod;

  @override
  Widget build(BuildContext context) {
    final scale = adaptiveTextScale(context);
    final period = copyrightPeriod ?? '2022 - 2025';
    final verticalPad =
        (MediaQuery.of(context).size.height * 0.025).clamp(8.0, 24.0);
    return Padding(
      padding: EdgeInsets.symmetric(vertical: verticalPad, horizontal: 16),
      child: Text(
        '© Derechos Reservados $period Universidad de Colima',
        style: TextStyle(
          fontSize: 10 * scale,
          fontWeight: FontWeight.w400,
          color: Colors.white,
          height: 1.1,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
