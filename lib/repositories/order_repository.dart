import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter_restaurant_store/bloc/core/failure.dart';
import 'package:flutter_restaurant_store/injection.dart';
import 'package:flutter_restaurant_store/models/order/order.dart';
import 'package:flutter_restaurant_store/models/order/orders.dart';
import 'package:flutter_restaurant_store/repositories/core/local_injectable_module.dart';
import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';

@lazySingleton
class OrderRepository {
  Future<void> getOrders({
    required String token,
    required int page,
    required int pageLimit,
    String? key,
    String? status,
    required void Function(List<Orders> orders) onCompleted,
    required void Function(Failure failure) onError,
  }) async {
    try {
      final uri = Uri(
        scheme: getIt<LocalInjectableModule>().schemeApi,
        host: getIt<LocalInjectableModule>().hostApi,
        port: getIt<LocalInjectableModule>().portApi,
        path: '/api/v1/user/order',
        queryParameters: {
          'page': page.toString(),
          'page_limit': pageLimit.toString(),
          'key': key,
          'status': status,
        },
      );
      final response = await http.get(
        uri,
        headers: {HttpHeaders.authorizationHeader: 'Bearer $token'},
      );
      final body = jsonDecode(response.body) as Map;

      if (response.statusCode != 200) {
        onError(
          Failure(
            message: body['message'].toString(),
            statusCode: response.statusCode,
          ),
        );
      } else {
        final list = (body['data'] as List).cast<Map>();
        final orders =
            list.map((data) => Orders.fromJson(data.cast())).toList();
        onCompleted(orders);
      }
    } catch (e, stackTrace) {
      log(e.toString(), error: e, stackTrace: stackTrace);
      onError(Failure(message: e.toString(), error: e, stackTrace: stackTrace));
    }
  }

  Future<void> getOrderById({
    required String token,
    required String orderId,
    required void Function(Order order) onCompleted,
    required void Function(Failure failure) onError,
  }) async {
    try {
      final uri = Uri(
        scheme: getIt<LocalInjectableModule>().schemeApi,
        host: getIt<LocalInjectableModule>().hostApi,
        port: getIt<LocalInjectableModule>().portApi,
        path: '/api/v1/user/order/$orderId',
      );
      final response = await http.get(
        uri,
        headers: {HttpHeaders.authorizationHeader: 'Bearer $token'},
      );
      final body = jsonDecode(response.body) as Map;

      if (response.statusCode != 200) {
        onError(
          Failure(
            message: body['message'].toString(),
            statusCode: response.statusCode,
          ),
        );
      } else {
        final data = body['data'] as Map;
        final order = Order.fromJson(data.cast());
        onCompleted(order);
      }
    } catch (e, stackTrace) {
      log(e.toString(), error: e, stackTrace: stackTrace);
      onError(Failure(message: e.toString(), error: e, stackTrace: stackTrace));
    }
  }
}
