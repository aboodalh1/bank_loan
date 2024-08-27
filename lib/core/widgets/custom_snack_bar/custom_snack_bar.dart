import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
void customSnackBar(context,String text){
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(text,style: GoogleFonts.almarai(),),
      showCloseIcon: true,
      behavior: SnackBarBehavior.floating,
      padding: const EdgeInsetsDirectional.all(10),


    ),
  );
}