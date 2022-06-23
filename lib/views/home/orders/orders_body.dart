import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_restaurant_store/bloc/order/orders/orders_cubit.dart';
import 'package:flutter_restaurant_store/models/order/orders.dart';
import 'package:flutter_restaurant_store/views/core/misc/constants.dart';
import 'package:flutter_restaurant_store/views/core/widgets/error_text.dart';
import 'package:flutter_restaurant_store/views/home/orders/widgets/order_tile_widget.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class OrdersBody extends StatefulWidget {
  const OrdersBody({Key? key}) : super(key: key);

  @override
  _OrdersBodyState createState() => _OrdersBodyState();
}

class _OrdersBodyState extends State<OrdersBody> {
  final _ordersPagingController =
      PagingController<int, Orders>(firstPageKey: 0);

  static const _ordersPageLimit = 10;

  @override
  void initState() {
    _ordersPagingController.addPageRequestListener((pageKey) {
      context.read<OrdersCubit>().getOrders(
            // token: context.read<AuthCubit>().state.authToken!.token,
            token: '1c7b3156-986b-487b-8d6c-2db03806ca30',
            pageKey: pageKey,
            pageLimit: _ordersPageLimit,
            onCompleted: (orders) {
              if (orders.length < _ordersPageLimit) {
                _ordersPagingController.appendLastPage(orders);
              } else {
                final nextPageKey = pageKey + orders.length;
                _ordersPagingController.appendPage(orders, nextPageKey);
              }
            },
            onError: (message) {
              _ordersPagingController.error = message;
            },
          );
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async => _ordersPagingController.refresh(),
      child: PagedListView<int, Orders>.separated(
        pagingController: _ordersPagingController,
        padding: kListPadding,
        separatorBuilder: (_, __) => const SizedBox(height: 6),
        builderDelegate: PagedChildBuilderDelegate(
          firstPageErrorIndicatorBuilder: (context) {
            return ErrorText(
              message: _ordersPagingController.error.toString(),
              onRetry: () {
                _ordersPagingController.refresh();
              },
            );
          },
          itemBuilder: (context, order, index) {
            return OrderTile(
              order: order,
              onTap: () {
                // context.router.push(OrderDetailRoute(orderId: order.id));
              },
            );
          },
        ),
      ),
    );
  }
}
