import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

import '../../manger/home_cubit.dart';

class CustomBottomNavBar extends StatelessWidget {
  const CustomBottomNavBar({super.key, required this.cubit});

  final HomeCubit cubit;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        return SalomonBottomBar(
            currentIndex: cubit.currentIndex,
            onTap: (index) {
              cubit.changeBottomNavBar(index);
            },
            items: [
              SalomonBottomBarItem(
                icon: const Icon(Icons.home),
                selectedColor: const Color(0xFF004F9F),
                unselectedColor: Colors.black,
                title: const Text('الرئيسية'),
              ),
              SalomonBottomBarItem(
                icon: const Icon(Icons.person),
                selectedColor: const Color(0xFF004F9F),
                unselectedColor: Colors.black,
                title: const Text('العملاء'),
              )
            ]);
      },
    );
  }
}
