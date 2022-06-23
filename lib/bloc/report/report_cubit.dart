import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_restaurant_store/models/item_trend.dart';
import 'package:flutter_restaurant_store/repositories/report_repository.dart';
import 'package:injectable/injectable.dart';

part 'report_state.dart';

@injectable
class ReportCubit extends Cubit<ReportState> {
  ReportCubit(this._reportRepository) : super(ReportState.initial());

  final ReportRepository _reportRepository;

  Future<void> getReport() async {
    emit(state.copyWith(isLoading: true));
    await _reportRepository.getItemTrends(
      onCompleted: (report) {
        emit(state.copyWith(report: report, isLoading: false));
      },
      onError: (_) {
        emit(state.copyWith(isLoading: false));
      },
    );
  }
}
