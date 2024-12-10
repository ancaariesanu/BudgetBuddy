part of 'get_incomes_bloc.dart';

sealed class GetIncomesEvent extends Equatable {
  const GetIncomesEvent();

  @override
  List<Object> get props => [];
}

class GetIncomes extends GetIncomesEvent {}

class FetchMonthlyIncomes extends GetIncomesEvent {
  final int year;
  final int month;

  const FetchMonthlyIncomes(this.year, this.month);

  @override
  List<Object> get props => [year, month];
}