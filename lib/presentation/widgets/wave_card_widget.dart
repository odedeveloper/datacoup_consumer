import 'package:datacoup/export.dart';

class WaveCard extends StatelessWidget {
  const WaveCard({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: WavePainter(
        circleWidth: 64.0,
      ),
      size: Size(double.infinity, height(context)! * 0.15),
    );
  }
}

class WavePainter extends CustomPainter {
  double? circleWidth;
  WavePainter({this.circleWidth});
  @override
  void paint(Canvas canvas, Size size) {
    var fillPaint = Paint()
      ..color = Colors.amber.shade100
      ..strokeWidth = 1
      ..style = PaintingStyle.fill
      ..strokeCap = StrokeCap.round;
    var wavePaint = Paint()
      ..color = Colors.amber[900]!.withOpacity(0.1)
      ..strokeWidth = 1
      ..style = PaintingStyle.fill
      ..strokeCap = StrokeCap.round;
    Path path = Path();
    path.moveTo(0, size.height);
    path.cubicTo(size.width * 1 / 4, size.height * 1 / 4, size.width / 2,
        size.height / 2, size.width, 0);
    path.lineTo(size.width, size.height);
    var holePaint = Paint()
      ..color = Colors.blue
      ..strokeWidth = 1
      ..style = PaintingStyle.fill
      ..strokeCap = StrokeCap.round;
    Offset holeOffset = Offset(size.width / 2, size.height - circleWidth! / 6);
    canvas.drawRect(Rect.fromLTRB(0, 0, size.width, size.height), fillPaint);
    canvas.drawPath(path, wavePaint);
    // canvas.drawCircle(holeOffset, circleWidth!, holePaint);
  }

  @override
  bool shouldRepaint(WavePainter oldDelegate) => false;
  @override
  bool shouldRebuildSemantics(WavePainter oldDelegate) => false;
}
