import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:expense_repository/expense_repository.dart';

part 'get_incomes_event.dart';
part 'get_incomes_state.dart';

class GetIncomesBloc extends Bloc<GetIncomesEvent, GetIncomesState> {
  final IncomeRepository incomeRepository;

  GetIncomesBloc(this.incomeRepository) : super(GetIncomesInitial()) {
    on<GetIncomesEvent>((event, emit) async {
      emit(GetIncomesLoading());
      try {
        //final incomes = await incomeRepository.getIncomes(); // Use income repository method
        emit(GetIncomesSuccess());
      } catch (e) {
        emit(GetIncomesFailure());
      }
    });

    on<FetchMonthlyIncomes>((event, emit) async {
      emit(GetIncomesLoading());
      try {
        //final incomes = await incomeRepository.getIncomesByMonth(event.year, event.month);
        emit(GetIncomesSuccess());
      } catch (e) {
        emit(GetIncomesFailure());
      }
    });
  }
}
