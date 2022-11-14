import 'package:datacoup/export.dart';

class NavigationController extends GetxController {
  String currentPage = StringConst.HOME;
  int currentIndex = 0;
  List pageName = [
    StringConst.HOME,
    StringConst.FAVOURITE,
    StringConst.QNA,
    StringConst.QUICKS,
    StringConst.PROFILE
  ];
  updateCurrentPage(int value) {
    currentIndex = value;
    currentPage = pageName.elementAt(value);
    update();
  }
}
