import 'package:datacoup/export.dart';

class SimpleLoader extends StatelessWidget {
  const SimpleLoader({super.key});

  final Color color = deepOrangeColor;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        color: color,
      ),
    );
  }
}
