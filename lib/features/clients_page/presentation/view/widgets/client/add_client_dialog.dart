import 'package:bank_loan/core/widgets/custom_snack_bar/custom_snack_bar.dart';
import 'package:flutter/material.dart';

import '../../../../../../core/util/screen_size.dart';
import '../../../manger/clients_cubit.dart';


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
                onChanged: (val){
                  if(val.length>=30){
                    customSnackBar(context, 'لا يمكن للاسم أن يكون اكثر من 30 حرف');
                  }

                },
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