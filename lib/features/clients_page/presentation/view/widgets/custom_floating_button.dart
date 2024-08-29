import 'package:flutter/material.dart';
import '../../../../../core/util/screen_size.dart';


class CustomFloatingButton extends StatelessWidget {
  const  CustomFloatingButton({
    super.key,
     required this.onPressed,
     required this.label,
  });

  final VoidCallback? onPressed;
  final String label;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: 140,
      child: FloatingActionButton(
         onPressed: onPressed,
        child:  Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(label,
                style: TextStyle(color: Colors.white, height: -0.2,fontSize: ScreenSizeUtil.screenWidth * 0.04)),
            SizedBox(width: 5,),
            Icon(
              Icons.add,
              color: Colors.white,
                size: ScreenSizeUtil.screenWidth * 0.04
            ),
          ],
        ),
      ),
    );
  }
}
