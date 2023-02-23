import 'package:datacoup/export.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NewsScreen extends GetWidget<NewsController> {
  const NewsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: 15.h,
          ),
          SizedBox(
            height: 248.h,
            child: const NewsOfTheDayWidget(),
          ),
          SizedBox(height: 15.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.h),
            child: SizedBox(
              height: 50.h,
              child: Row(children: [
                Expanded(
                  flex: 1,
                  child: InkWell(
                    onTap: () {
                      Get.to(() => SocialMediaFeedWidget());
                    },
                    child: Container(
                        height: 50.h,
                        decoration: BoxDecoration(
                          // color: greyColor,
                          border: Border.all(color: greyColor, width: 2),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              FontAwesomeIcons.boltLightning,
                              color: deepOrangeColor,
                            ),
                            SizedBox(
                              width: 10.w,
                            ),
                            Text(
                              "Latest Feeds",
                              style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontFamily: AssetConst.QUICKSAND_FONT,
                              ),
                            )
                          ],
                        )),
                  ),
                ),
                SizedBox(
                  width: 20.w,
                ),
                Expanded(
                  flex: 1,
                  child: InkWell(
                    onTap: () {
                      Get.to(VideoReelsScreen());
                    },
                    child: Container(
                        height: 50.h,
                        decoration: BoxDecoration(
                          // color: greyColor,
                          border: Border.all(color: greyColor, width: 2.5),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              FontAwesomeIcons.play,
                              color: deepOrangeColor,
                            ),
                            SizedBox(
                              width: 10.w,
                            ),
                            Text(
                              "Short Videos",
                              style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontFamily: AssetConst.QUICKSAND_FONT,
                              ),
                            )
                          ],
                        )),
                  ),
                ),
              ]),
            ),
          ),
          SizedBox(
            height: 10.h,
          ),
          NewsByInterest(),
          // NewsByInterest(),
          // SizedBox(
          //   height: height(context)! * 0.32,
          //   child: const NewsByInterest(),
          // ),
          // SizedBox(
          //   height: height(context)! * 0.31,
          //   child: const VideoOfTheDayWidget(),
          // ),
          // SizedBox(
          //   height: height(context)! * 0.3,
          //   child: const TrendingVideosWidget(),
          // ),
        ],
      ),
    );
  }
}
