import 'package:flutter/material.dart';
import '../../util/screen_size.dart';

void customSnackBar(context,String text){
  ScaffoldMessenger.of(context).clearSnackBars();
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(text, style: TextStyle(fontSize:ScreenSizeUtil.screenWidth * 0.04),),
      showCloseIcon: true,
      behavior: SnackBarBehavior.floating,
      padding: const EdgeInsetsDirectional.all(10),

    ),
  );
}