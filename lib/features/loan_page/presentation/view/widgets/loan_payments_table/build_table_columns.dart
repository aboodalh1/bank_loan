import 'package:flutter/material.dart';

import '../../../../../../core/util/screen_size.dart';

List<DataColumn> buildTableColumns() {
  return [
    DataColumn(
        label: Text(
      'رقم الدفعة',
      style: TextStyle(fontSize: ScreenSizeUtil.screenWidth * 0.04),
    )),
    DataColumn(
        label: Text(
      'مجموع الدفعات',
      style: TextStyle(fontSize: ScreenSizeUtil.screenWidth * 0.04),
    )),
    DataColumn(
        label: Text(
      'الأساسي',
      style: TextStyle(fontSize: ScreenSizeUtil.screenWidth * 0.04),
    )),
    DataColumn(
        label: Text(
      'الفائدة',
      style: TextStyle(fontSize: ScreenSizeUtil.screenWidth * 0.04),
    )),
    DataColumn(
        label: Text(
      'الرصيد',
      style: TextStyle(fontSize: ScreenSizeUtil.screenWidth * 0.04),
    )),
    DataColumn(
        label: Text(
      'المبلغ المتبقي',
      style: TextStyle(fontSize: ScreenSizeUtil.screenWidth * 0.04),
    )),
  ];
}
