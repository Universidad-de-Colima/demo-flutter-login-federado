part of widgets;

class BlueButton extends StatelessWidget {
  const BlueButton({
    super.key,
    this.onPressed,
    this.maxWith = 300.0,
  });
  final VoidCallback? onPressed;
  final double maxWith;
  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(maxWidth: maxWith),
      child: MaterialButton(
        minWidth: double.infinity,
        padding: const EdgeInsets.all(16),
        elevation: 4,
        highlightElevation: 2,
        onPressed: onPressed,
        color: UdcColors.blue,
        child: Text(
          'Iniciar sesión',
          style: Theme.of(context)
              .textTheme
              .headlineSmall!
              .copyWith(color: Colors.white),
        ),
      ),
    );
  }
}
