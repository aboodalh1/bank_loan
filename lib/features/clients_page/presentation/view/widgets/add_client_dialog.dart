import 'package:flutter/material.dart';

import '../../manger/clients_cubit.dart';

void showAddClientDialog(BuildContext context, ClientsCubit cubit) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Directionality(
        textDirection: TextDirection.rtl,
        child: AlertDialog(
          backgroundColor: Colors.white,
          title: const Text('إضافة زبون جديد'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: cubit.nameController,
                decoration: const InputDecoration(labelText: 'اسم الزبون'),
              ),
              TextField(
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
                controller: cubit.dateController,
                decoration: const InputDecoration(labelText: 'تاريخ التقديم'),
                keyboardType: TextInputType.datetime,
              ),
            ],
          ),
          actions: [
            TextButton(
              child: const Text('إلغاء',style: TextStyle(color: Colors.black),),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('إضافة', style: TextStyle(color: Color(0xFF004F9F))),
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