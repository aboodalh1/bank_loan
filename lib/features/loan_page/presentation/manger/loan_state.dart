part of 'loan_cubit.dart';

@immutable
sealed class LoanState {}

final class HomeInitial extends LoanState {}

final class ShowLoanTable extends LoanState{}

final class HideLoanTable extends LoanState{}

final class GenerateResults extends LoanState{}

final class ValidAmount extends LoanState{}

final class InValidAmount extends LoanState{}