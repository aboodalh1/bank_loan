import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../../core/util/screen_size.dart';
import '../../manger/clients_cubit.dart';
import 'package:flutter/services.dart';

class AlphanumericAndArabicTextInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue,
      TextEditingValue newValue,
      ) {
    final newText = newValue.text;

    // Regular expression to include Arabic letters (ا-ي), Arabic digits (٠-٩), and Latin letters and digits
    final filteredText = newText.replaceAll(RegExp(r'[^a-zA-Z0-9ا-ي٠-٩]'), '');

    return newValue.copyWith(
      text: filteredText,
      selection: TextSelection.collapsed(offset: filteredText.length),
    );
  }
}
void showAddClientDialog(BuildContext context, ClientsCubit cubit) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Directionality(
        textDirection: TextDirection.rtl,
        child: AlertDialog(
          backgroundColor: Colors.white,
          title:  Text('إضافة زبون جديد',style: TextStyle(fontSize: ScreenSizeUtil.screenWidth * 0.04),),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                inputFormatters: [
         AlphanumericAndArabicTextInputFormatter()
                ],
                controller: cubit.nameController,
                decoration:  InputDecoration(labelText: 'اسم الزبون',labelStyle: TextStyle(fontSize: ScreenSizeUtil.screenWidth * 0.04)),
              ),
              TextField(

                style: TextStyle(fontSize: ScreenSizeUtil.screenWidth * 0.04),
                onTap: ()async{
                  final DateTime ? picked= await showDatePicker(
                    context: context,
                    firstDate: DateTime(1900),
                    initialDate: DateTime.now(),
                    lastDate: DateTime(2030),
                    builder: (BuildContext context, Widget? child) {
                      return Theme(
                        data: ThemeData.light().copyWith(
                          colorScheme: const ColorScheme.light(
                            primary: Color(0xFF004F9F), // This changes the color of the circle of the selected day
                          ),
                        ),
                        child: child!,
                      );
                    },
                  );
                  if(picked!=null){
                    cubit.dateController.text=picked.toString().substring(0,10);
                  }
                },
                inputFormatters: [],
                controller: cubit.dateController,
                decoration:  InputDecoration(labelText: 'تاريخ التقديم',labelStyle: TextStyle(fontSize: ScreenSizeUtil.screenWidth * 0.04)),
                keyboardType: TextInputType.datetime,
              ),
            ],
          ),
          actions: [
            TextButton(
              child:  Text('إلغاء',style: TextStyle(color: Colors.black,fontSize: ScreenSizeUtil.screenWidth * 0.04),),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child:  Text('إضافة', style: TextStyle(color: Color(0xFF004F9F),fontSize: ScreenSizeUtil.screenWidth * 0.04)),
              onPressed: () {
                cubit.insertClient();
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      );
    },
  );
}