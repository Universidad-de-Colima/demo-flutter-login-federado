part of screens;

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FlutterStatusbarcolor.setStatusBarWhiteForeground(false);
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const UdcLogo(),
            const SizedBox(height: 24),
            BlueButton(onPressed: () {}),
          ],
        ),
      ),
    );
  }
}
