part of screens;

class WhiteSecondaryScreen extends StatelessWidget {
  const WhiteSecondaryScreen({Key? key, required this.data}) : super(key: key);
  final WayfLoginModel data;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login correcto'),
      ),
      body: Text(
        data.displayName.first,
        style: Theme.of(context).textTheme.headline3,
      ),
    );
  }
}
