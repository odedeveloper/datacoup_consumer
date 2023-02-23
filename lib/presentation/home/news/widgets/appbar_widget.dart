import 'package:datacoup/export.dart';
import 'package:datacoup/presentation/authentication/account/update_account.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class NewsScreenAppBar extends StatelessWidget {
  NewsScreenAppBar(
      {Key? key,
      required this.title,
      required this.subTitle,
      required this.image})
      : super(key: key);

  final String title;
  final String subTitle;
  final String image;
  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      toolbarHeight: 80.h,
      title: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(title,
                  style: themeTextStyle(
                    tColor: Theme.of(context).primaryColor,
                    fsize: 24.h,
                    fweight: FontWeight.w800,
                    fontFamily: AssetConst.QUICKSAND_FONT,
                    context: context,
                  )),
              Text(
                subTitle,
                overflow: TextOverflow.ellipsis,
                style: themeTextStyle(
                  tColor: Colors.grey.shade500,
                  fsize: 16.h,
                  fweight: FontWeight.w700,
                  fontFamily: AssetConst.QUICKSAND_FONT,
                  context: context,
                ),
              ),
            ]),
            Spacer(),
            Image.asset(
              image,
              height: 50.h,
              color: Theme.of(context).primaryColor,
            ),
          ]),
    );
  }
}
