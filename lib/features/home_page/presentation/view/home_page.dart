import 'package:bank_loan/features/home_page/presentation/manger/home_cubit.dart';
import 'package:bank_loan/features/home_page/presentation/view/widgets/custom_bottom_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit(),
      child: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          var cubit = context.read<HomeCubit>();
          return Scaffold(
              key: cubit.scaffoldKey,
              bottomNavigationBar: CustomBottomNavBar(
                cubit: cubit,
              ),
              body: AnimatedSwitcher(
                transitionBuilder: (child, animation) => AnimatedBuilder(
                  animation: animation,
                  child: child,
                  builder: (context, child) {
                    final rotateY =
                        Tween<double>(begin: 1, end: 0).animate(animation);
                    return Transform(
                      transform: Matrix4.rotationY(rotateY.value),
                      alignment: Alignment.center,
                      child: child,
                    );
                  },
                ),
                duration: const Duration(milliseconds: 200),
                child: cubit.screens[cubit.currentIndex],
              ));
        },
      ),
    );
  }
}

