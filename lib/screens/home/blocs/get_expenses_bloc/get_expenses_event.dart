part of 'get_expenses_bloc.dart';

sealed class GetExpensesEvent extends Equatable {
  const GetExpensesEvent();

  @override
  List<Object> get props => [];
}

class GetExpenses extends GetExpensesEvent {}

class FetchMonthlyExpenses extends GetExpensesEvent {
  final int year;
  final int month;

  const FetchMonthlyExpenses(this.year, this.month);

  @override
  List<Object> get props => [year, month];
}
