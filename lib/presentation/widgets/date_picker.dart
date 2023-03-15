import 'package:datacoup/export.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

Future<String> selectDate(BuildContext context) async {
  final DateTime? selected = await showDatePicker(
    context: context,
    builder: (BuildContext context, Widget? child) {
      return Theme(
        data: ThemeData(
          primarySwatch: Colors.orange,
          splashColor: Colors.white,
          // colorScheme: ColorScheme.light(
          //   primary: Color(0xffffbc00),
          // ),
          dialogBackgroundColor: Colors.white,
        ),
        child: child ?? Text(""),
      );
    },
    initialDate: DateTime(DateTime.now().year - 18),
    firstDate: DateTime(1970),
    lastDate: DateTime(DateTime.now().year - 17),
  );
  if (selected != null && selected != DateTime.now()) {
    DateFormat dateFormat = DateFormat("MM-dd-yyyy");
    String date = dateFormat.format(selected);
    return date;
  } else {
    return "";
  }
}
