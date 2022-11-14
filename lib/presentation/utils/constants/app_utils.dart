import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

showSnackBar(BuildContext context, {int durationInSeconds = 2, String msg = '', Color backgroundColor = Colors.redAccent}){
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(msg),
    duration: Duration(seconds: durationInSeconds),
    backgroundColor:backgroundColor,
  ));
}

getFormattedDate(date){
 return DateFormat.yMMMEd().format(date);
}

formatString(int size,String value){
  if(value.length<size){
    return value+" "*(size-value.length);
  }
  else{
    return value.substring(0,size-3)+" ..";
  }
}

// getThumbnail(String videoUrl) async{
//   var data = GetStorage().read("videoOfTheDay");
//   if(data!=null){
//     return data;
//   }
//   else{
//       final uint8list = await VideoThumbnail.thumbnailData(
//       video:videoUrl,
//       imageFormat: ImageFormat.JPEG,
//       maxWidth: 128, // specify the width of the thumbnail, let the height auto-scaled to keep the source aspect ratio
//       quality: 25,
//     );
//     GetStorage().write("videoOfTheDay",uint8list);
//     return uint8list;
//   }

  // getThumbnail(String videoUrl) async{
  //     final uint8list = await VideoThumbnail.thumbnailData(
  //     video:videoUrl,
  //     imageFormat: ImageFormat.JPEG,
  //     // maxWidth: 128,
  //     maxHeight: 200, // specify the width of the thumbnail, let the height auto-scaled to keep the source aspect ratio
  //     quality: 25,
  //   );
  //   return uint8list;
  // }