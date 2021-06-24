part of screens;

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key, required this.onWayfResolve}) : super(key: key);
  final OnWayfResolve onWayfResolve;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const UdcLogo(),
            const SizedBox(height: 24),
            BlueButton(onPressed: () => _toLogin(context)),
          ],
        ),
      ),
    );
  }

  void _toLogin(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return WayfWebViewScreen(onWayfResolve: onWayfResolve);
        },
      ),
    );
  }
}
