import 'package:equatable/equatable.dart';

class ItemTrend extends Equatable {
  final DateTime date;
  final int totalSales;

  const ItemTrend({
    required this.date,
    required this.totalSales,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'date': date.toIso8601String(),
      'total_sales': totalSales,
    };
  }

  factory ItemTrend.fromJson(Map<String, dynamic> map) {
    return ItemTrend(
      date: DateTime.parse(map['date'] as String),
      totalSales: map['total_sales'] as int,
    );
  }

  @override
  List<Object?> get props => [date, totalSales];
}
