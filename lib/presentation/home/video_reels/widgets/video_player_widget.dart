import 'package:datacoup/export.dart';
import 'package:datacoup/presentation/home/video_reels/widgets/youtube_player_widget.dart';

class VideoPlayerWidget extends StatefulWidget {
  const VideoPlayerWidget({
    Key? key,
    required this.items,
    this.startIndex,
  }) : super(key: key);

  final int? startIndex;
  final List<Item>? items;

  @override
  State<VideoPlayerWidget> createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  late PageController _pageController;
  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: widget.startIndex!);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.black,
      ),
      body: PageView.builder(
        controller: _pageController,
        itemBuilder: (context, index) => YoutuberPlayerWidget(
          videoDetail: widget.items![index],
        ),
        itemCount: widget.items!.length,
        scrollDirection: Axis.vertical,
        onPageChanged: (i) {},
      ),
    );
  }
}
