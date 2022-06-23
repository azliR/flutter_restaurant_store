// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:firebase_auth/firebase_auth.dart' as _i3;
import 'package:flutter_restaurant_store/bloc/auth/auth_cubit.dart' as _i12;
import 'package:flutter_restaurant_store/bloc/order/order_detail/order_detail_cubit.dart'
    as _i10;
import 'package:flutter_restaurant_store/bloc/order/orders/orders_cubit.dart'
    as _i6;
import 'package:flutter_restaurant_store/bloc/preferences/preferences_cubit.dart'
    as _i7;
import 'package:flutter_restaurant_store/bloc/report/report_cubit.dart' as _i11;
import 'package:flutter_restaurant_store/repositories/auth_repository.dart'
    as _i9;
import 'package:flutter_restaurant_store/repositories/core/firebase_injectable_module.dart'
    as _i13;
import 'package:flutter_restaurant_store/repositories/core/local_injectable_module.dart'
    as _i4;
import 'package:flutter_restaurant_store/repositories/order_repository.dart'
    as _i5;
import 'package:flutter_restaurant_store/repositories/report_repository.dart'
    as _i8;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

const String _prod = 'prod';
const String _dev = 'dev';
// ignore_for_file: unnecessary_lambdas
// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  final firebaseInjectableModule = _$FirebaseInjectableModule();
  gh.lazySingleton<_i3.FirebaseAuth>(
      () => firebaseInjectableModule.firebaseAuth);
  gh.factory<_i4.LocalInjectableModule>(() => _i4.DevModule(),
      registerFor: {_prod});
  gh.factory<_i4.LocalInjectableModule>(() => _i4.ProdModule(),
      registerFor: {_dev});
  gh.lazySingleton<_i5.OrderRepository>(() => _i5.OrderRepository());
  gh.factory<_i6.OrdersCubit>(
      () => _i6.OrdersCubit(get<_i5.OrderRepository>()));
  gh.factory<_i7.PreferencesCubit>(() => _i7.PreferencesCubit());
  gh.lazySingleton<_i8.ReportRepository>(() => _i8.ReportRepository());
  gh.lazySingleton<_i9.AuthRepository>(
      () => _i9.AuthRepository(get<_i3.FirebaseAuth>()));
  gh.factory<_i10.OrderDetailCubit>(
      () => _i10.OrderDetailCubit(get<_i5.OrderRepository>()));
  gh.factory<_i11.ReportCubit>(
      () => _i11.ReportCubit(get<_i8.ReportRepository>()));
  gh.factory<_i12.AuthCubit>(() => _i12.AuthCubit(get<_i9.AuthRepository>()));
  return get;
}

class _$FirebaseInjectableModule extends _i13.FirebaseInjectableModule {}
