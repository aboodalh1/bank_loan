import 'package:flutter/material.dart';

import '../../../../../core/util/screen_size.dart';

class CustomCircularButton extends StatelessWidget {
  const CustomCircularButton(
      {super.key, required this.onPressed, required this.label});

  final String label;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.disabled)) return Colors.grey;
          return const Color(0xFF004F9F);
        }),
      ),
      onPressed: onPressed,
      child: SizedBox(
        width: ScreenSizeUtil.screenWidth*0.2,
        child: Text(
          textAlign: TextAlign.center,
          label,
          style: TextStyle(
              color: Colors.white,
              fontSize: ScreenSizeUtil.screenWidth * 0.035,
              fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}
