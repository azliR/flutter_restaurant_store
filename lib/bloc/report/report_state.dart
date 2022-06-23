part of 'report_cubit.dart';

class ReportState extends Equatable {
  const ReportState({
    required this.report,
    this.isLoading = false,
  });

  final Map<String, List<ItemTrend>> report;
  final bool isLoading;

  factory ReportState.initial() => const ReportState(report: {});

  ReportState copyWith({
    Map<String, List<ItemTrend>>? report,
    bool? isLoading,
  }) {
    return ReportState(
      report: report ?? this.report,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  List<Object?> get props => [report];
}
