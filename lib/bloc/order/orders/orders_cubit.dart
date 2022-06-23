import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_restaurant_store/bloc/core/failure.dart';
import 'package:flutter_restaurant_store/models/order/orders.dart';
import 'package:flutter_restaurant_store/repositories/order_repository.dart';
import 'package:injectable/injectable.dart';

part 'orders_state.dart';

@injectable
class OrdersCubit extends Cubit<OrdersState> {
  OrdersCubit(this._orderRepository) : super(OrdersState.initial());

  final OrderRepository _orderRepository;

  Future<void> getOrders({
    required String token,
    required int pageKey,
    required int pageLimit,
    String? key,
    String? status,
    required void Function(List<Orders> orders) onCompleted,
    required void Function(Failure failure) onError,
  }) async {
    await _orderRepository.getOrders(
      token: token,
      page: pageKey ~/ pageLimit + 1,
      pageLimit: pageLimit,
      onCompleted: onCompleted,
      onError: onError,
    );
  }
}
