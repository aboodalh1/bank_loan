
import 'package:flutter/material.dart';

import '../../manger/loan_cubit.dart';

class CustomDropDown extends StatelessWidget {
  const CustomDropDown({
    super.key,
    required this.cubit,
  });

  final LoanCubit cubit;
  @override
  Widget build(BuildContext context) {
    return DropdownMenu(
        controller: cubit.monthNumberController,
        width: 90,
        dropdownMenuEntries: const [
          DropdownMenuEntry(
            label: '12',
            value: 12,
          ),
          DropdownMenuEntry(
            label: '18',
            value: 18,
          ),
          DropdownMenuEntry(
            label: '24',
            value: 24,
          ),
        ]);
  }
}
