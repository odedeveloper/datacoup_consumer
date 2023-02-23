import 'package:datacoup/export.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class SingleVideoPlayer extends StatelessWidget {
  const SingleVideoPlayer({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(color: deepOrangeColor),
        elevation: 0,
      ),
    );
  }
}
