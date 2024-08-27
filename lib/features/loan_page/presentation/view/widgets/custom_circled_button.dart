import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomCircularButton extends StatelessWidget {
  const CustomCircularButton(
      {super.key, required this.onPressed, required this.label});

  final String label;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ButtonStyle(

        backgroundColor: MaterialStateProperty.resolveWith((states)
    {
      if (states.contains(MaterialState.disabled)) return Colors.grey;
      return const Color(0xFF004F9F);

    }),),
    onPressed: onPressed,
    child: SizedBox(
    child: Text(
    label,
    style: GoogleFonts.almarai(
    color: Colors.white, fontSize: 14, fontWeight: FontWeight.w600),
    )
    ,
    )
    ,
    );
  }
}
