import 'package:flutter/material.dart';

import '../../manger/clients_cubit.dart';

void showEditClientDialog(BuildContext context, ClientsCubit cubit,num id) {
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
                controller: cubit.editNameController,
                decoration: const InputDecoration(labelText: 'اسم الزبون'),
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
                cubit.editClient(id: id);
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      );
    },
  );
}