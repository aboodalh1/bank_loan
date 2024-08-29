import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../manger/clients_cubit.dart';

void showEditLoanDialog(BuildContext context, ClientsCubit cubit,num id,num costumerId) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Directionality(
        textDirection: TextDirection.rtl,
        child: AlertDialog(
          backgroundColor: Colors.white,
          title: const Text('تعديل عدد الدفعات'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'^\d{0,2}(\.\d{0,2})?$'))
                ],
                keyboardType: TextInputType.number,
                controller: cubit.paymentsController,
                decoration: const InputDecoration(labelText: 'عدد الدفعات'),
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
              child: const Text('تعديل', style: TextStyle(color: Color(0xFF004F9F))),
              onPressed: () {
                cubit.editLoan(id: id,paymentsNumber: num.parse(cubit.paymentsController.text),costumerId: costumerId);
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      );
    },
  );
}