import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:expense_repository/expense_repository.dart';

part 'create_expense_event.dart';
part 'create_expense_state.dart';

class CreateExpenseBloc extends Bloc<CreateExpenseEvent, CreateExpenseState> {
  final ExpenseRepository expenseRepository;

  CreateExpenseBloc(this.expenseRepository) : super(CreateExpenseInitial()) {
    on<CreateExpense>((event, emit) async {
      print("Processing CreateExpense event with expense: ${event.expense}");
      emit(CreateExpenseLoading());
      try {
        await expenseRepository.createExpense(event.expense);
        print("Successfully created expense: ${event.expense}");
        emit(CreateExpenseSuccess(event.expense));
      } catch (e) {
        print("Error creating expense: $e");
        emit(CreateExpenseFailure());
      }
    });
  }
}
