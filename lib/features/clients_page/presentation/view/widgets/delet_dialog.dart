import 'package:flutter/material.dart';

import '../../manger/clients_cubit.dart';

void showDeleteConfirmation(
    BuildContext context, String clientName, int id, ClientsCubit cubit) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: Colors.white,

        title: const Text('حذف زبون'),
        content: Text(
            'هل انت متأكد من انك تريد حذف  $clientName؟ \nلا يمكن التراجع عن هذا الخيار.'),
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
              cubit.deleteData(id: id);
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
