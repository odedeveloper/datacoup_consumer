import 'package:datacoup/export.dart';

class NewsScreen extends GetWidget<NewsController> {
  const NewsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: Column(
          children: [
            SizedBox(
              height: height(context)! * 0.3,
              child: const NewsOfTheDayWidget(),
            ),
            const SizedBox(height: 5),
            SizedBox(
              height: height(context)! * 0.32,
              child: const NewsByInterest(),
            ),
            SizedBox(
              height: height(context)! * 0.31,
              child: const VideoOfTheDayWidget(),
            ),
            SizedBox(
              height: height(context)! * 0.3,
              child: const TrendingVideosWidget(),
            ),
            SizedBox(
              height: height(context)! * 0.75,
              child: const SocialMediaFeedWidget(),
            ),
          ],
        ),
      ),
    );
  }
}
