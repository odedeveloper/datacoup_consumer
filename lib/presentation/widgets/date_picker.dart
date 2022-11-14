import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

Future<String> selectDate(BuildContext context) async {
    final DateTime? selected = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1970),
      lastDate: DateTime.now(),

    );
    if (selected != null && selected != DateTime.now()){
      DateFormat dateFormat = DateFormat("dd-MM-yyyy");
      String date  = dateFormat.format(selected);
      return date;
    }
    else{
      return "";
    }
  }