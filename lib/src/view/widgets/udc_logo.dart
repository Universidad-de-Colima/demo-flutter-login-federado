part of widgets;

class UdcLogo extends StatelessWidget {
  const UdcLogo({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Image(
        image: NetworkImage(
          'https://portal.ucol.mx/content/micrositios/188/image/Escudo2021/1_Linea/UdeC%20Abajo_Negro_80_.png',
        ),
        semanticLabel: 'Logo Universidad de Colima',
      ),
    );
  }
}
