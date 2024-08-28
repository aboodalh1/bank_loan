
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/util/screen_size.dart';
import '../../../../loan_page/presentation/manger/loan_cubit.dart';
import '../../manger/clients_cubit.dart';
import '../add_client_loan_screen.dart';

class CustomFloatingButton extends StatelessWidget {
  const CustomFloatingButton({
    super.key,
    required this.uId,
    required this.cubit,
  });

  final num uId;
  final ClientsCubit cubit;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: 140,
      child: FloatingActionButton(
         onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    MultiBlocProvider(
                      providers: [
                        BlocProvider.value(
                          value: cubit,
                        ),
                        BlocProvider(
                          create: (context) => LoanCubit(),
                        ),
                      ],
                      child: AddClientLoanScreen(

                        id: uId,
                      ),
                    )),
          );
        },
        child:  Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("إضافة قرض",
                style: TextStyle(color: Colors.white, height: -0.2,fontSize: ScreenSizeUtil.screenWidth * 0.04)),
            SizedBox(width: 5,),
            Icon(
              Icons.add,
              color: Colors.white,
                size: ScreenSizeUtil.screenWidth * 0.04
            ),
          ],
        ),
      ),
    );
  }
}
