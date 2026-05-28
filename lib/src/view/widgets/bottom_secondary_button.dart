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
    super.key,
  });

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

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);
    return Container(
      width: media.size.width,
      height: double.infinity,
      decoration: const BoxDecoration(
        color: UdcColors.actionSecondary,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(72),
        ),
      ),
      child: Column(
        children: [
          Expanded(
            child: Center(
              child: _ButtonWrapper(
                onPressed: onPressed,
                text: text,
                icon: buttonIcon,
                style: buttonStyle,
              ),
            ),
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
    final media = MediaQuery.of(context);
    final defaultStyle = TextButton.styleFrom(
      backgroundColor: Colors.white,
      padding: EdgeInsets.symmetric(
        horizontal: media.size.width * 0.1,
        vertical: 15,
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
    return Text(
      text,
      style: const TextStyle(
        fontSize: 20,
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
    final period = copyrightPeriod ?? '2022 - 2025';
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24),
      child: Text(
        '© Derechos Reservados $period Universidad de Colima',
        style: const TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w400,
          color: Colors.white,
          height: 1.1,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
