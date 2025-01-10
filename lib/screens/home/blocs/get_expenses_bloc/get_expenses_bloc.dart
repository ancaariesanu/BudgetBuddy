import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:expense_repository/expense_repository.dart';

part 'get_expenses_event.dart';
part 'get_expenses_state.dart';

class GetExpensesBloc extends Bloc<GetExpensesEvent, GetExpensesState> {
  ExpenseRepository expenseRepository;

  GetExpensesBloc(this.expenseRepository) : super(GetExpensesInitial()) {
    on<GetExpenses>((event, emit) async {
      emit(GetExpensesLoading());
      try {
        List<Expense> expenses = await expenseRepository.getExpenses();
        Map<String, double> categoryTotals = calculateTotalAmountPerCategory(expenses);
        emit(GetExpensesSuccess(expenses, categoryTotals));
      } catch (e) {
        emit(GetExpensesFailure());
      }
    });

    on<FetchMonthlyExpenses>((event, emit) async {
      emit(GetExpensesLoading());
      try {
        // Fetch expenses for the specified month and year
        final expenses = await expenseRepository.getExpensesByMonth(event.year, event.month);

        // Aggregate data if needed (e.g., totals or grouping by category)
        final monthlyTotals = calculateTotalAmountPerCategory(expenses);

        emit(GetExpensesSuccess(expenses, monthlyTotals));
      } catch (e) {
        emit(GetExpensesFailure());
      }
    });

    on<GetExpensesWithReceipts>((event, emit) async {
      emit(GetExpensesLoading());
      try {
        final expenses = await expenseRepository.getExpensesWithReceipts();
        emit(GetExpensesSuccess(expenses, {})); // No category totals needed for this case
      } catch (e) {
        emit(GetExpensesFailure());
      }
    });


  }

  Map<String, double> calculateTotalAmountPerCategory(List<Expense> expenses) {
    Map<String, double> totalByCategory = {};

    for (var expense in expenses) {
      final categoryName = expense.category.name;
      totalByCategory[categoryName] = (totalByCategory[categoryName] ?? 0) + expense.amount;
    }

    return totalByCategory;
  }
  
}
