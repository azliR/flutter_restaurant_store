import 'package:equatable/equatable.dart';
import 'package:flutter_restaurant_store/models/enums/enums.dart';
import 'package:meta/meta.dart';

@immutable
class Orders extends Equatable {
  const Orders({
    required this.id,
    required this.customerId,
    required this.storeId,
    this.storeAccountId,
    this.tableId,
    this.couponId,
    required this.buyer,
    required this.storeName,
    this.storeImage,
    this.tableName,
    this.tablePrice,
    this.couponCode,
    this.couponName,
    this.discount,
    this.discountType,
    this.discountNominal,
    required this.brutto,
    required this.netto,
    required this.status,
    required this.orderType,
    this.scheduledAt,
    required this.pickupType,
    required this.createdAt,
    required this.totalItem,
  });

  final String id;
  final String customerId;
  final String storeId;
  final String? storeAccountId;
  final String? tableId;
  final String? couponId;
  final String buyer;
  final String storeName;
  final String? storeImage;
  final String? tableName;
  final double? tablePrice;
  final String? couponCode;
  final String? couponName;
  final double? discount;
  final DiscountType? discountType;
  final double? discountNominal;
  final double brutto;
  final double netto;
  final OrderStatus status;
  final OrderType orderType;
  final DateTime? scheduledAt;
  final PickupType pickupType;
  final DateTime createdAt;
  final int totalItem;

  factory Orders.fromJson(Map<String, dynamic> json) => Orders(
        id: json['id'] as String,
        customerId: json['customer_id'] as String,
        storeId: json['store_id'] as String,
        storeAccountId: json['store_account_id'] as String?,
        tableId: json['table_id'] as String?,
        couponId: json['coupon_id'] as String?,
        buyer: json['buyer'] as String,
        storeName: json['store_name'] as String,
        storeImage: json['store_image'] as String?,
        tableName: json['table_name'] as String?,
        tablePrice: json['table_price'] as double?,
        couponCode: json['coupon_code'] as String?,
        couponName: json['coupon_name'] as String?,
        discount: json['discount'] as double?,
        discountType: json['discount_type'] == null
            ? null
            : DiscountType.fromString(json['discount_type'] as String),
        discountNominal: json['discount_nominal'] as double?,
        brutto: json['brutto'] as double,
        netto: json['netto'] as double,
        status: OrderStatus.fromString(json['status'] as String),
        orderType: OrderType.fromString(json['order_type'] as String),
        scheduledAt: json['scheduled_at'] == null
            ? null
            : DateTime.parse(json['scheduled_at'] as String),
        pickupType: PickupType.fromString(json['pickup_type'] as String),
        createdAt: DateTime.parse(json['created_at'] as String),
        totalItem: json['total_item'] as int,
      );

  Orders copyWith({
    String? id,
    String? customerId,
    String? storeId,
    String? storeAccountId,
    String? tableId,
    String? couponId,
    String? buyer,
    String? storeName,
    String? storeImage,
    String? tableName,
    double? tablePrice,
    String? couponCode,
    String? couponName,
    double? discount,
    DiscountType? discountType,
    double? discountNominal,
    double? brutto,
    double? netto,
    OrderStatus? status,
    OrderType? orderType,
    DateTime? scheduledAt,
    PickupType? pickupType,
    DateTime? createdAt,
    int? totalItem,
  }) {
    return Orders(
      id: id ?? this.id,
      customerId: customerId ?? this.customerId,
      storeId: storeId ?? this.storeId,
      storeAccountId: storeAccountId ?? this.storeAccountId,
      tableId: tableId ?? this.tableId,
      couponId: couponId ?? this.couponId,
      buyer: buyer ?? this.buyer,
      storeName: storeName ?? this.storeName,
      storeImage: storeImage ?? this.storeImage,
      tableName: tableName ?? this.tableName,
      tablePrice: tablePrice ?? this.tablePrice,
      couponCode: couponCode ?? this.couponCode,
      couponName: couponName ?? this.couponName,
      discount: discount ?? this.discount,
      discountType: discountType ?? this.discountType,
      discountNominal: discountNominal ?? this.discountNominal,
      brutto: brutto ?? this.brutto,
      netto: netto ?? this.netto,
      status: status ?? this.status,
      orderType: orderType ?? this.orderType,
      scheduledAt: scheduledAt ?? this.scheduledAt,
      pickupType: pickupType ?? this.pickupType,
      createdAt: createdAt ?? this.createdAt,
      totalItem: totalItem ?? this.totalItem,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'customer_id': customerId,
        'store_id': storeId,
        'store_account_id': storeAccountId,
        'table_id': tableId,
        'coupon_id': couponId,
        'buyer': buyer,
        'store_name': storeName,
        'store_image': storeImage,
        'table_name': tableName,
        'table_price': tablePrice,
        'coupon_code': couponCode,
        'coupon_name': couponName,
        'discount': discount,
        'discount_type': discountType?.toString(),
        'discount_nominal': discountNominal,
        'brutto': brutto,
        'netto': netto,
        'status': status.name,
        'order_type': orderType.name,
        'scheduled_at': scheduledAt?.toIso8601String(),
        'pickup_type': pickupType.name,
        'created_at': createdAt.toIso8601String(),
        'total_item': totalItem,
      }..removeWhere((key, value) => key == 'order_details' && value == null);

  @override
  List<Object?> get props {
    return [
      id,
      customerId,
      storeId,
      storeAccountId,
      tableId,
      couponId,
      buyer,
      storeName,
      storeImage,
      tableName,
      tablePrice,
      couponCode,
      couponName,
      discount,
      discountType,
      discountNominal,
      brutto,
      netto,
      status,
      orderType,
      scheduledAt,
      pickupType,
      createdAt,
      totalItem,
    ];
  }
}
