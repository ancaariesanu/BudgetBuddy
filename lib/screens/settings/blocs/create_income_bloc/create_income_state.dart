part of 'create_income_bloc.dart';

sealed class CreateIncomeState extends Equatable {
  const CreateIncomeState();
  
  @override
  List<Object> get props => [];
}

final class CreateIncomeInitial extends CreateIncomeState {}

final class CreateIncomeFailure extends CreateIncomeState {}

final class CreateIncomeLoading extends CreateIncomeState {}

final class CreateIncomeSuccess extends CreateIncomeState {}
