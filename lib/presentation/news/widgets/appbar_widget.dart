import 'package:datacoup/export.dart';
import 'package:intl/intl.dart';

class NewsScreenAppBar extends StatelessWidget {
  NewsScreenAppBar({Key? key}) : super(key: key);

  final controller = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 20,
      leadingWidth: 100,
      leading: Row(
        children: [
          const SizedBox(width: 10),
          FaIcon(
            FontAwesomeIcons.locationDot,
            color: darkGreyColor,
            size: 22,
          ),
          const SizedBox(width: 5),
          SizedBox(
            width: 60,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Countrysfsfjalsfjslajflk",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: themeTextStyle(
                    context: context,
                    fsize: kminiFont(context)! - 2,
                    fweight: FontWeight.w500,
                  ),
                ),
                Text(
                  "city",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: themeTextStyle(
                    context: context,
                    fsize: kminiFont(context)! - 2,
                    fweight: FontWeight.w500,
                  ),
                ),
                Text(
                  "Zi sfsdfasf sdfsfdp",
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: themeTextStyle(
                    context: context,
                    fsize: kminiFont(context)! - 2,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      centerTitle: true,
      title: CacheImageWidget(
        fromAsset: true,
        imageUrl: AssetConst.logoPng,
        imgheight: height(context)! * 0.05,
        imgwidth: width(context)! * 0.12,
      ),
      actions: [
        Obx(() {
          final user = controller.user?.value;
          return Row(
            children: [
              user?.firstName == null
                  ? const Center(
                      child: SpinKitThreeBounce(
                      size: 25,
                      duration: Duration(milliseconds: 800),
                      color: Colors.grey,
                    ))
                  : SizedBox(
                      width: 80,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            user!.firstName!,
                            maxLines: 1,
                            textAlign: TextAlign.right,
                            overflow: TextOverflow.ellipsis,
                            style: themeTextStyle(
                              context: context,
                              fsize: ksmallFont(context),
                              fweight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            DateFormat('MMMM d').format(DateTime.now()),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: themeTextStyle(
                              context: context,
                              fsize: kminiFont(context),
                            ),
                          ),
                        ],
                      ),
                    ),
              const SizedBox(width: 5),
              InkWell(
                onTap: () {},
                child: user?.profileImage == null
                    ? const CircleAvatar(
                        radius: 18, backgroundColor: Colors.grey)
                    : CircleAvatar(
                        radius: 18,
                        backgroundColor: Colors.grey,
                        child: CircleAvatar(
                          radius: 16,
                          backgroundImage: NetworkImage(user!.profileImage!),
                        ),
                      ),
              ),
              const SizedBox(width: 10),
            ],
          );
        })
      ],
    );
  }
}
