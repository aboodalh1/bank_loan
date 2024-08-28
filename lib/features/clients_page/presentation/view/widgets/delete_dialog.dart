import 'package:flutter/material.dart';

import '../../../../../core/util/screen_size.dart';
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
            child:  Text('إلغاء',style: TextStyle(color: Colors.black,fontSize: ScreenSizeUtil.screenWidth * 0.04),),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child:  Text('حذف', style: TextStyle(color: Colors.red,fontSize: ScreenSizeUtil.screenWidth * 0.04)),
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
