part of widgets;

class UdcLogo extends StatelessWidget {
  const UdcLogo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    const expectedSize = 200.0;
    final screenSize = 0.8 * MediaQuery.of(context).size.width;
    final minSize = min(expectedSize, screenSize);
    final maxSize = max(expectedSize, screenSize);
    return ConstrainedBox(
      constraints: BoxConstraints(
        minWidth: minSize,
        maxWidth: maxSize,
      ),
      child: const Image(
        image: NetworkImage(
          'https://recursos.ucol.mx/tesis/img/logo_negro.png',
        ),
        semanticLabel: 'Logo Universidad de Colima',
      ),
    );
  }
}
