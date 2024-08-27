part of 'home_cubit.dart';

@immutable
sealed class HomeState {}

final class HomeInitial extends HomeState {}

final class ChangeBottomNavBar extends HomeState {}

final class ShowBottomSheetState extends HomeState {}
