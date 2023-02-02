part of widgets;

/// Styled button to place in bottom of screen
class BottomSecondaryButton extends StatelessWidget {
  /// Styled button to place in bottom of screen
  const BottomSecondaryButton({
    super.key,
    required this.onPressed,
    required this.text,
  });

  /// Callback to be called when the button is pressed
  final VoidCallback onPressed;

  /// Text to be displayed in the button
  final String text;

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);
    return Container(
      width: media.size.width,
      height: double.infinity,
      decoration: const BoxDecoration(
        color: UdcColors.secondary,
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
              ),
            ),
          ),
          const _Disclaimer()
        ],
      ),
    );
  }
}

class _ButtonWrapper extends StatelessWidget {
  const _ButtonWrapper({
    required this.onPressed,
    required this.text,
  });
  final VoidCallback onPressed;
  final String text;
  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
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
      ),
      child: _ButtonText(text: text),
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
  const _Disclaimer();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 24),
      child: Text(
        '© Derechos Reservados 2022 - 2025 Universidad de Colima',
        style: TextStyle(
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
