
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../loan_page/presentation/manger/loan_cubit.dart';

class TableButtonsRow extends StatelessWidget {
  const TableButtonsRow({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          icon:
          const Icon(Icons.print, color: Colors.black),
          onPressed: () {
            context.read<LoanCubit>().printTable(context);
          },
        ),
        IconButton(
          icon: const Icon(Icons.picture_as_pdf,
              color: Colors.red),
          onPressed: () {
            context.read<LoanCubit>().saveAsPdf(context);
          },
        ),
        IconButton(
          icon: const Icon(Icons.table_chart,
              color: Colors.green),
          onPressed: () {
            context.read<LoanCubit>().saveAsXls(context);
          },
        ),
      ],
    );
  }
}
