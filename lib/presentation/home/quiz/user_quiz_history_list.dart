import 'package:datacoup/domain/model/activity_item_model.dart';
import 'package:datacoup/export.dart';
import 'package:datacoup/presentation/home/quiz/qna/quiz_result_generic.dart';
import 'package:datacoup/presentation/home/quiz/qna_homepage_controller.dart';
import 'package:datacoup/presentation/home/quiz/quiz_history_result_controller.dart';

class QuizHistoryListItem extends StatelessWidget {
  final ActivityItemModel item;
  QuizHistoryListItem(this.item, {Key? key}) : super(key: key);
  final _QnaHomePageController = Get.put(QnaHomePageController());

  String getDate(String timestamp) {
// String year = timestamp.year.toString();

    // final dateTimeUTC = DateTime.parse(timestamp).toUtc();
    // print("Date in utc: ${dateTimeUTC}");
    // final dateTimeLocal = dateTimeUTC.toLocal();
    // print("Date in local: ${dateTimeLocal}");
    // print("Date in string utc: ${dateTimeUTC.toString()}");
    // print("Date in string local: ${dateTimeLocal.toString()}");
    // // convert to local time
    // final dateTimeString = dateTimeLocal.toString();
    // print("The local time is: ${dateTimeString}");
    // convert to local time
    // final dateTimeLocal = dateTimeUTC.toLocal();
    List<String> unformattedDateTime = timestamp.split(' ');
    List<String> unformattedDate = unformattedDateTime[0].split('-');

    String year = unformattedDate[0];
    String month = unformattedDate[1];
    Map<String, String> monthsInName = {
      '01': 'Jan',
      '02': 'Feb',
      '03': 'Mar',
      '04': 'Apr',
      '05': 'May',
      '06': 'Jun',
      '07': 'Jul',
      '08': 'Aug',
      '09': 'Sep',
      '10': 'Oct',
      '11': 'Nov',
      '12': 'Dec',
    };
    String day = unformattedDate[2];
    if (day[0] == '0') day = day.substring(1);

    // dynamic namedMonth = DateFormat.M().format(month);

    return '$day ${monthsInName[month]}';

    // final DateTime date =
    //     DateTime.fromMillisecondsSinceEpoch(int.parse(timestamp) * 1000);
    // var formattedDate = DateFormat.MMMd().format(date);
    // // var date = DateTime.fromMicrosecondsSinceEpoch(int.parse(timestamp));
    // return formattedDate;
  }

  String getTime(String timestamp) {

    // final dateTimeUTC = DateTime.parse(timestamp).toUtc();
    // print("Date in utc: ${dateTimeUTC}");
    // final dateTimeLocal = dateTimeUTC.toLocal();
    // print("Date in local: ${dateTimeLocal}");
    // print("Date in string utc: ${dateTimeUTC.toString()}");
    // print("Date in string local: ${dateTimeLocal.toString()}");
    // // convert to local time
    // final dateTimeString = dateTimeLocal.toString();
    // print("The local time is: ${dateTimeString}");

    List<String> unformattedDateTime = timestamp.split(' ');
    List<String> unformattedTime = unformattedDateTime[1].split(':');

    String hour = unformattedTime[0];
    String minutes = unformattedTime[1];
    if (hour[0] == '0') hour = hour.substring(1);

    return '$hour:$minutes';
    // final DateTime date =
    //     DateTime.fromMillisecondsSinceEpoch(int.parse(timestamp) * 1000);
    // var formattedTime = DateFormat.jm().format(date);
    // // var date = DateTime.fromMicrosecondsSinceEpoch(int.parse(timestamp));
    // return formattedTime;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.all(5),
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(5)),
          color: Theme.of(context).cardColor,
        ),
        child: InkWell(
          onTap: () async {
            var quizHistoryResultController =
                Get.find<QuizHistoryResultController>();
            quizHistoryResultController.updateActivity(item);
            Get.to(() => QuizHistoryResult(activity: item));
          },
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
            SizedBox(
              width: width(context)! * 0.15,
              child: Text(item.topic == '' ? 'Privacy Laws' : item.topic,
                  // textAlign: alignment,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Theme.of(context).primaryColorDark,
                    fontSize: width(context)! * 0.038,
                    fontWeight: FontWeight.w800,
                    fontFamily: AssetConst.QUICKSAND_FONT,
                  )),
            ),
            SizedBox(
              width: width(context)! * 0.15,
              child: Text("${item.score}/100",
                  // textAlign: alignment,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Theme.of(context).primaryColorDark,
                    fontSize: width(context)! * 0.038,
                    fontWeight: FontWeight.w800,
                    fontFamily: AssetConst.QUICKSAND_FONT,
                  )),
            ),
            SizedBox(
              width: width(context)! * 0.15,
              child: Text(getDate(item.timestamp),
                  // textAlign: alignment,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Theme.of(context).primaryColorDark,
                    fontSize: width(context)! * 0.038,
                    fontWeight: FontWeight.w800,
                    fontFamily: AssetConst.QUICKSAND_FONT,
                  )),
            ),
            SizedBox(
              width: width(context)! * 0.15,
              child: Text(getTime(item.timestamp),
                  // textAlign: alignment,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Theme.of(context).primaryColorDark,
                    fontSize: width(context)! * 0.038,
                    fontWeight: FontWeight.w800,
                    fontFamily: AssetConst.QUICKSAND_FONT,
                  )),
            ),
          ]),
        ));
  }
}

class UserHistoryList extends StatelessWidget {
  final String odenId;
  const UserHistoryList({required this.odenId, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(bottom: 20),
        child: GetBuilder<QnaHomePageController>(builder: (controller) {
          return Container(
              // decoration: BoxDecoration(
              //     color: Theme.of(context).appBarTheme.backgroundColor,
              //     borderRadius: BorderRadius.circular(10),
              //     boxShadow: const [
              //       BoxShadow(
              //         color: Colors.black,
              //         blurRadius: 0.3,
              //         spreadRadius: 0.2,
              //       )
              //     ]),
              padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
              child: SizedBox(
                  width: double.infinity,
                  child: controller.userHistory.isEmpty
                      ? Center(
                          child: Text('You have not taken any quiz yet !',
                              style: TextStyle(
                                  fontSize: width(context)! * 0.025,
                                  fontFamily: AssetConst.QUICKSAND_FONT,
                                  color: mediumGreyColor)),
                        )
                      : Column(
                          children: List.generate(
                              controller.userHistory.length,
                              (index) => QuizHistoryListItem(
                                  controller.userHistory[index])),
                          // itemCount: controller.userHistory.length,
                          // itemBuilder: (context, index) {
                          //   return QuizHistoryListItem(
                          //       controller.userHistory[index]);
                        )));
        }));
  }
}
