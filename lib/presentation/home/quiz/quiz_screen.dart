import 'package:datacoup/export.dart';

class QuizScreen extends StatelessWidget {
  const QuizScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Quizzes",
          style: themeTextStyle(
            context: context,
            fweight: FontWeight.bold,
            fsize: klargeFont(context),
          ),
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 20),
              SizedBox(
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    CustomPaint(
                      size:
                          Size(width(context)! * 0.8, height(context)! * 0.35),
                      painter: CirclePainter(),
                    ),
                    CustomPaint(
                      size:
                          Size(width(context)! * 0.55, height(context)! * 0.25),
                      painter: CirclePainter(),
                    ),
                    Container(
                      padding: const EdgeInsets.all(35),
                      decoration: BoxDecoration(
                        color: Theme.of(context).appBarTheme.backgroundColor,
                        borderRadius:
                            BorderRadius.circular(width(context)! * 0.7),
                        boxShadow: const [
                          BoxShadow(blurRadius: 1, spreadRadius: 0.1)
                        ],
                      ),
                      child: CacheImageWidget(
                        fromAsset: true,
                        imageUrl: AssetConst.digitalWarrior,
                        imgheight: height(context)! * 0.08,
                        imgwidth: width(context)! * 0.2,
                      ),
                    ),
                    Positioned(
                      left: width(context)! * 0.23,
                      bottom: -1.0,
                      child: Container(
                        color: Theme.of(context).scaffoldBackgroundColor,
                        width: width(context)! * 0.35,
                        child: Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius:
                                    BorderRadius.circular(kBorderRadius),
                              ),
                              child: Text(
                                "100/100",
                                style: themeTextStyle(
                                  context: context,
                                  tColor: Colors.white,
                                  fsize: kextraLargeFont(context),
                                ),
                              ),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              "Best Score",
                              style: themeTextStyle(
                                context: context,
                                fweight: FontWeight.w200,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Text(
                StringConst.QNA_PROFILE_PAGE_TEXT,
                textAlign: TextAlign.center,
                style: themeTextStyle(
                  context: context,
                  fsize: klargeFont(context),
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: width(context)! * 0.5,
                child: RoundedElevatedButton(
                  onClicked: () {
                    Get.to(() => const AllQuizWidget());
                  },
                  title: "Take Quiz",
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Recent Quizzes",
                    style: themeTextStyle(
                      context: context,
                      fsize: klargeFont(context),
                    ),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.all(12),
                height: height(context)! * 0.4,
                decoration: BoxDecoration(
                  color: Theme.of(context).appBarTheme.backgroundColor,
                  borderRadius: BorderRadius.circular(kBorderRadius),
                  boxShadow: const [
                    BoxShadow(blurRadius: 1, spreadRadius: 0.1)
                  ],
                ),
                child: ListView.separated(
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 10),
                  padding: const EdgeInsets.all(12),
                  itemCount: 8,
                  itemBuilder: (context, index) {
                    return Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Theme.of(context).scaffoldBackgroundColor,
                        borderRadius: BorderRadius.circular(kBorderRadius),
                      ),
                      child: Text(
                        "data",
                        style: themeTextStyle(context: context),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

class CirclePainter extends CustomPainter {
  final _paint = Paint()
    ..color = Colors.blue
    ..strokeWidth = 2
    // Use [PaintingStyle.fill] if you want the circle to be filled.
    ..style = PaintingStyle.stroke;

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawOval(
      Rect.fromLTWH(0, 0, size.width, size.height),
      _paint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
