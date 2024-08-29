import 'package:bank_loan/core/util/screen_size.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomNumberFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    final regExp = RegExp(r'^\d{0,8}(\.\d{0,2})?$');

    if (regExp.hasMatch(newValue.text)) {
      return newValue;
    }


    return oldValue;
  }
}
class CustomNumberFormatter1 extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    final regExp = RegExp(r'^\d{0,2}(\.\d{0,2})?$');

    if (regExp.hasMatch(newValue.text)) {
      return newValue;
    }


    return oldValue;
  }
}
Padding customTextField(context,
    {bool? isBenefit,bool? isEnabled,ValueChanged<String>? onChanged,Icon? icon,required String label,required String hintText, required TextEditingController controller}) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text(label,style: TextStyle(fontFamily: 'Almarai',fontSize: ScreenSizeUtil.screenWidth*0.040),),
        const SizedBox(height: 10,),
        SizedBox(
          width: ScreenSizeUtil.screenWidth*.5,
          child: TextFormField(
            enabled: isEnabled,
            keyboardType: const TextInputType.numberWithOptions(decimal: true,),
            inputFormatters: [
              isBenefit!? CustomNumberFormatter1():CustomNumberFormatter(),
              ],
            onChanged: onChanged,
            style: TextStyle(fontFamily: 'Almarai',color: Colors.black87,fontSize: ScreenSizeUtil.screenWidth*0.040),
            decoration: InputDecoration(
              suffixIcon: controller.text.isEmpty ? null : icon,
                hintText: hintText,
                hintStyle: TextStyle(fontFamily: 'Almarai',color: Colors.grey,fontSize: ScreenSizeUtil.screenWidth*0.040),
                border: InputBorder.none,
                fillColor: Colors.white,
                filled: true,

                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide:
                    const BorderSide(color: Color(0xFF004F9F), width: 2.0)),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(
                        color: Color(0xFF004F9F), width: 2.0))),
            controller: controller,
          ),
        )
      ],
    ),
  );
}
