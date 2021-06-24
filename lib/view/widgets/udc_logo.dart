part of widgets;

class UdcLogo extends StatelessWidget {
  const UdcLogo({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(
        maxHeight: 200,
        minHeight: 80,
        maxWidth: 200,
        minWidth: 80,
      ),
      child: Image.asset(
        udcLogoPath,
        semanticLabel: 'Logo Universidad de Colima',
      ),
    );
  }
}
