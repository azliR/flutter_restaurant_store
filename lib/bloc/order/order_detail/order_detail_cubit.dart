import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_restaurant_store/bloc/core/failure.dart';
import 'package:flutter_restaurant_store/models/order/order.dart';
import 'package:flutter_restaurant_store/repositories/order_repository.dart';
import 'package:injectable/injectable.dart';

part 'order_detail_state.dart';

@injectable
class OrderDetailCubit extends Cubit<OrderDetailState> {
  OrderDetailCubit(
    this._orderRepository,
  ) : super(OrderDetailState.initial());

  final OrderRepository _orderRepository;

  Future<void> getOrderById({
    required String token,
    required String orderId,
  }) async {
    emit(
      state.copyWith(
        isLoading: true,
        failure: null,
      ),
    );
    await _orderRepository.getOrderById(
      token: token,
      orderId: orderId,
      onCompleted: (order) {
        emit(
          state.copyWith(
            order: order,
            isLoading: false,
          ),
        );
      },
      onError: (failure) {
        emit(
          state.copyWith(
            failure: failure,
            isLoading: false,
          ),
        );
      },
    );
  }
}
