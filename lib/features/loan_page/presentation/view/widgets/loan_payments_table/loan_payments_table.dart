import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../../../core/util/screen_size.dart';
import '../../../manger/loan_cubit.dart';
import 'build_table_columns.dart';
import 'build_table_rows.dart';

class LoanPaymentTable extends StatelessWidget {
  final LoanCubit cubit;
  final TransformationController _transformationController =
      TransformationController();

  LoanPaymentTable({
    super.key,
    required this.cubit,
  });

  @override
  Widget build(BuildContext context) {
    return InteractiveViewer(
      transformationController: _transformationController,
      minScale: 0.5,
      maxScale: 2.5,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          dividerThickness: 0.1,
          columnSpacing: ScreenSizeUtil.screenWidth * 0.08,
          headingRowColor: MaterialStateColor.resolveWith(
              (states) => const Color(0xFF004F9F)),
          headingTextStyle: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: ScreenSizeUtil.screenWidth * 0.04),
          rows: buildTableRows(cubit),
          columns: buildTableColumns()
        ),
      ),
    );
  }


}
