import 'dart:convert';
import 'dart:developer';

import 'package:flutter_restaurant_store/bloc/core/failure.dart';
import 'package:flutter_restaurant_store/injection.dart';
import 'package:flutter_restaurant_store/models/item_trend.dart';
import 'package:flutter_restaurant_store/repositories/core/local_injectable_module.dart';
import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';

@lazySingleton
class ReportRepository {
  Future<void> getItemTrends({
    required void Function(Map<String, List<ItemTrend>> itemTrend) onCompleted,
    required void Function(Failure failure) onError,
  }) async {
    try {
      final uri = Uri(
        scheme: getIt<LocalInjectableModule>().schemeApi,
        host: getIt<LocalInjectableModule>().hostApi,
        port: getIt<LocalInjectableModule>().portApi,
        path: '/api/v1/store/trend/item',
        queryParameters: {},
      );
      final response = await http.get(uri);
      final body = jsonDecode(response.body) as Map;

      if (response.statusCode != 200) {
        onError(
          Failure(
            message: body['message'].toString(),
            statusCode: response.statusCode,
          ),
        );
      } else {
        final list = (body['data'] as Map).cast<String, List>();
        final itemTrend = list.map(
          (key, value) => MapEntry(
            key,
            value.cast<Map>().map((e) => ItemTrend.fromJson(e.cast())).toList(),
          ),
        );
        onCompleted(itemTrend);
      }
    } catch (e, stackTrace) {
      log(e.toString(), error: e, stackTrace: stackTrace);
      onError(Failure(message: e.toString(), error: e, stackTrace: stackTrace));
    }
  }
}
