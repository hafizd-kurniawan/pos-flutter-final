import 'package:flutter/material.dart';
import 'package:flutter_pos_responsive_app/core/components/buttons.dart';
import 'package:flutter_pos_responsive_app/core/extensions/date_time_ext.dart';
import 'package:flutter_pos_responsive_app/core/extensions/int_ext.dart';
import 'package:flutter_pos_responsive_app/core/extensions/string_ext.dart';
import 'package:print_bluetooth_thermal/print_bluetooth_thermal.dart';

import '../../../core/assets/assets.gen.dart';
import '../../../core/constants/colors.dart';
import '../../../data/dataoutput/printer_service.dart';
import '../../../data/models/response/history_response_model.dart';
import '../../home/models/order_item.dart';

class HistoryTransactionCard extends StatelessWidget {
  final History data;
  final EdgeInsetsGeometry? padding;

  const HistoryTransactionCard({super.key, required this.data, this.padding});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: padding,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, 2),
            blurRadius: 48.0,
            blurStyle: BlurStyle.outer,
            spreadRadius: 0,
            color: AppColors.black.withOpacity(0.06),
          ),
        ],
      ),
      child: ExpansionTile(
        shape: RoundedRectangleBorder(
          side: BorderSide.none,
          borderRadius: BorderRadius.circular(0.0),
        ),
        title: Row(
          children: [
            Assets.icons.payments.svg(),
            const SizedBox(width: 12.0),
            Flexible(
              flex: 6,
              child: Text(
                // ignore: unrelated_type_equality_checks
                '${data.createdAt!.toFormattedTime()} - ${data.paymentMethod! == 'QR'
                    ? 'QRIS'
                    : data.paymentMethod! == 'TRANSFER'
                    ? 'TRANSFER'
                    : 'Cash'}',
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            const Spacer(),
            Flexible(
              flex: 4,
              child: Text(
                double.parse(data.totalPrice!).toInt().currencyFormatRp,
                style: const TextStyle(
                  color: AppColors.green,
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        ),
        children: [
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: data.orderItems!.length + 1,
            itemBuilder: (context, index) {
              if (index == data.orderItems!.length) {
                return Padding(
                  padding: const EdgeInsets.only(
                    top: 4.0,
                    left: 16,
                    right: 16,
                    bottom: 16,
                  ),
                  child: Button.filled(
                    onPressed: () async {
                      // print receipt
                      // final printInt = await CwbPrint.instance.printOrderV2(
                      //   data.orders,
                      //   data.totalQuantity,
                      //   data.totalPrice,
                      //   data.paymentMethod,
                      //   data.nominalBayar,
                      //   data.namaKasir,
                      //   'Customer',
                      // );
                      // CwbPrint.instance.printReceipt(printInt);
                      final orderItems = data.orderItems!.map((e) {
                        return OrderItem(
                          quantity: e.quantity!,
                          product: e.product!,
                        );
                      }).toList();
                      final printValue = await PrinterService.instance
                          .printOrder(
                            data.paymentMethod?.toString() ?? '',
                            orderItems,
                            data.totalItem ?? 0,
                            double.parse(data.totalPrice!).toInt(),
                          );

                      await PrintBluetoothThermal.writeBytes(printValue);
                    },
                    label: 'Print Receipt',
                  ),
                );
              }
              final item = data.orderItems![index];
              return ListTile(
                title: Text(item.product!.name ?? 'Product ${index + 1}'),
                subtitle: Text(
                  '${item.quantity} x ${double.parse(item.product!.price!).toInt().currencyFormatRp}',
                ),
                trailing: Text(
                  '${item.quantity! * double.parse(item.product!.price!).toInt()}'
                      .currencyFormatRp,
                  style: const TextStyle(
                    color: AppColors.green,
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              );
              //button print
            },
          ),
        ],
      ),
    );
  }
}
