import 'package:flutter/material.dart';

import '../../manger/clients_cubit.dart';

void showDeleteConfirmation(
    {num ?uId,required bool isClient,required String title,required context,required  String headerTitle,required  int id,required  ClientsCubit cubit}) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: Colors.white,
        title:  Text(headerTitle),
        content: Text(
            title),
        actions: [
          TextButton(
            child: const Text('إلغاء',style: TextStyle(color: Colors.black),),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: const Text('حذف', style: TextStyle(color: Colors.red)),
            onPressed: () {
              if(isClient)
                cubit.deleteClient(id: id);
                else cubit.deleteLoan(id: id, uId: uId!);
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
