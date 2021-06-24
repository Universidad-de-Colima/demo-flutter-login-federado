part of widgets;

class BlueButton extends StatelessWidget {
  const BlueButton({
    Key? key,
    this.onPressed,
    this.maxWith = 300.0,
  }) : super(key: key);
  final VoidCallback? onPressed;
  final double maxWith;
  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(maxWidth: maxWith),
      child: MaterialButton(
        minWidth: double.infinity,
        padding: const EdgeInsets.all(16.0),
        elevation: 4,
        highlightElevation: 2.0,
        onPressed: onPressed,
        color: UdcColors.blue,
        child: Text(
          'Iniciar sesión',
          style: Theme.of(context)
              .textTheme
              .headline5!
              .copyWith(color: Colors.white),
        ),
      ),
    );
  }
}
