import 'package:datacoup/export.dart';
import 'package:datacoup/presentation/widgets/back_button.dart';

class DigitalSoreScreen extends StatelessWidget {
  const DigitalSoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).cardColor,
        appBar: AppBar(
            elevation: 0,
            centerTitle: false,
            // backgroundColor: whiteColor,
            leading: const CustomBackButton(),
            title: Text(
              "Digital Score",
              style: themeTextStyle(
                context: context,
                fsize: klargeFont(context),
                fweight: FontWeight.bold,
              ),
            )),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 15,
                ),
                Container(
                  height: 300.h,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Score Factors",
                  style: themeTextStyle(
                    context: context,
                    tColor: Theme.of(context).primaryColor,
                    fweight: FontWeight.w800,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  "Factors that effect your digital score",
                  style: themeTextStyle(
                      context: context,
                      tColor: Colors.grey.shade600,
                      fweight: FontWeight.w800,
                      fsize: 14),
                ),
                SizedBox(
                  height: 10,
                ),
                Column(
                  children: [
                    FactorList(
                      icon: AssetConst.PASSWORD_STRENGTH,
                      title: 'Password strength',
                      text: 'Very strong',
                    ),
                    FactorList(
                      icon: AssetConst.PASSWORD_REUSE,
                      title: 'Password reusability',
                      text: 'Using unique password',
                    ),

                    FactorList(
                      icon: AssetConst.DATA_BREACH,
                      title: 'Data breaches',
                      text: '9 breaches found',
                    ),
                    FactorList(
                      icon: AssetConst.OS,
                      title: 'Device operating system',
                      text: 'Outdated version -19.0',
                    ),

                    // ExpansionTile(
                    //   title: Text('List-B'),
                    //   children: _getChildren(3, 'B-'),
                    // ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class FactorList extends StatelessWidget {
  FactorList({
    super.key,
    required this.title,
    required this.icon,
    required this.text,
  });
  final String title;
  String text;
  String icon;
  // List<Widget> childrens;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: whiteColor,
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: ExpansionTile(
        leading: Image.asset(
          icon,
          height: 45,
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: themeTextStyle(
                context: context,
                tColor: Theme.of(context).primaryColor,
                fweight: FontWeight.w800,
              ),
            ),
            SizedBox(height: 5),
            Text(
              text,
              style: themeTextStyle(
                  context: context,
                  tColor: Colors.grey.shade600,
                  fweight: FontWeight.w800,
                  fsize: 14),
            )
          ],
        ),
        children: [
          Text("s"),
          Text("s"),
          Text("s"),
          Text("s"),
          Text("s"),
          Text("s"),
          Text("s"),
          Text("s"),
          Text("s"),
          Text("s"),
          Text("s"),
          Text("s"),
          Text("s"),
          Text("s"),
          Text("s"),
          Text("s"),
          Text("s"),
          Text("s"),
        ],
      ),
    );
  }
}
