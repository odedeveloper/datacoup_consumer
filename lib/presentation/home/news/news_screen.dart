import 'package:datacoup/export.dart';

class NewsScreen extends StatelessWidget {
  const NewsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: PreferredSize(
      //     preferredSize: const Size(double.infinity, 56),
      //     child: NewsScreenAppBar()),
      body: SingleChildScrollView(
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
