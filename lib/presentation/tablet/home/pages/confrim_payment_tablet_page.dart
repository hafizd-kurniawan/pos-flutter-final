import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_pos_responsive_app/core/components/buttons.dart';
import 'package:flutter_pos_responsive_app/core/components/spaces.dart';
import 'package:flutter_pos_responsive_app/core/constants/colors.dart';
import 'package:flutter_pos_responsive_app/core/extensions/build_context_ext.dart';
import 'package:flutter_pos_responsive_app/core/extensions/int_ext.dart';
import 'package:flutter_pos_responsive_app/data/data_dummy.dart';
import 'package:flutter_pos_responsive_app/data/models/response/auth_response_model.dart';
import 'package:flutter_pos_responsive_app/presentation/tablet/home/widgets/order_menu.dart';


class ConfrimPaymentTabletPage extends StatefulWidget {
  const ConfrimPaymentTabletPage({super.key});

  @override
  State<ConfrimPaymentTabletPage> createState() =>
      _ConfrimPaymentTabletPageState();
}

class _ConfrimPaymentTabletPageState extends State<ConfrimPaymentTabletPage> {
  final totalPriceController = TextEditingController(text: '');
  String priceExcat = '0';
  int totalPrice = 0;
  AuthResponseModel? auth;
  bool isCash = true;
  @override
  void initState() {
    super.initState();
    loadData();
  }

  loadData() async {}

  @override
  Widget build(BuildContext context) {
    log('isCash $isCash');
    return SafeArea(
      child: Hero(
        tag: 'confirmation_screen',
        child: Scaffold(
          body: Row(
            children: [
              // LEFT CONTENT
              Expanded(
                flex: 2,
                child: Align(
                  alignment: Alignment.topCenter,
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Confirmation',
                                  style: TextStyle(
                                    color: AppColors.primary,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Text(
                                  'Orders #',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SpaceHeight(8.0),
                        const Divider(),
                        const SpaceHeight(24.0),
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Item',
                              style: TextStyle(
                                color: AppColors.primary,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(
                              width: 160,
                            ),
                            SizedBox(
                              width: 50.0,
                              child: Text(
                                'Qty',
                                style: TextStyle(
                                  color: AppColors.primary,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            SizedBox(
                              child: Text(
                                'Price',
                                style: TextStyle(
                                  color: AppColors.primary,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SpaceHeight(8),
                        const Divider(),
                        const SpaceHeight(8),
                        ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) =>
                              OrderMenu(data: dummyOrderItems[index]),
                          separatorBuilder: (context, index) =>
                              const SpaceHeight(16.0),
                          itemCount: dummyOrderItems.length,
                        ),
                        const SpaceHeight(16.0),
                        const SpaceHeight(8.0),
                        const Divider(),
                        const SpaceHeight(8.0),
                        Column(
                          children: [
                            const Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Subtotal',
                                    style: TextStyle(color: AppColors.grey),
                                  ),
                                  // Text(
                                  //   subTotal.currencyFormatRp,
                                  //   style: const TextStyle(
                                  //     color: AppColors.primary,
                                  //     fontWeight: FontWeight.w600,
                                  //   ),
                                  // ),
                                ]),
                            const SpaceHeight(8.0),
                            const Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Discount',
                                    style: TextStyle(color: AppColors.grey),
                                  ),
                                ]),
                            const SpaceHeight(8.0),
                            Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    'Tax',
                                    style: TextStyle(color: AppColors.grey),
                                  ),
                                  Text(
                                    10000.currencyFormatRp,
                                    style: const TextStyle(
                                      color: AppColors.primary,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ]),
                            const SpaceHeight(8.0),
                            const Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Service Charge',
                                    style: TextStyle(color: AppColors.grey),
                                  ),
                                  // Text(
                                  //   finalService.currencyFormatRp,
                                  //   style: const TextStyle(
                                  //     color: AppColors.primary,
                                  //     fontWeight: FontWeight.w600,
                                  //   ),
                                  // ),
                                ]),
                            const SpaceHeight(12.0),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'Total',
                                  style: TextStyle(
                                      color: AppColors.primary,
                                      fontWeight: FontWeight.w600),
                                ),
                                Text(
                                  totalPrice.currencyFormatRp,
                                  style: const TextStyle(
                                    color: AppColors.primary,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              // RIGHT CONTENT
              Expanded(
                flex: 3,
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Stack(
                    children: [
                      SingleChildScrollView(
                        padding: const EdgeInsets.all(24.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Payment',
                              style: TextStyle(
                                color: AppColors.primary,
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const Text(
                              '2 payment option available',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SpaceHeight(8.0),
                            const Divider(),
                            const SpaceHeight(8.0),
                            const Text(
                              'Pay Method',
                              style: TextStyle(
                                color: AppColors.primary,
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SpaceHeight(12.0),
                            Row(
                              children: [
                                isCash
                                    ? Button.filled(
                                        width: 120.0,
                                        height: 50.0,
                                        onPressed: () {
                                          isCash = true;
                                          setState(() {});
                                        },
                                        label: 'Cash',
                                      )
                                    : Button.outlined(
                                        width: 120.0,
                                        height: 50.0,
                                        onPressed: () {
                                          isCash = true;
                                          setState(() {});
                                        },
                                        label: 'Cash',
                                      ),
                                const SpaceWidth(8.0),
                                isCash
                                    ? Button.outlined(
                                        width: 120.0,
                                        height: 50.0,
                                        onPressed: () {
                                          isCash = false;
                                          setState(() {});
                                        },
                                        label: 'QR Pay',
                                      )
                                    : Button.filled(
                                        width: 120.0,
                                        height: 50.0,
                                        onPressed: () {
                                          isCash = false;
                                          setState(() {});
                                        },
                                        label: 'QR Pay',
                                      ),
                                const SpaceWidth(8.0),
                              ],
                            ),
                            const SpaceHeight(8.0),
                            const Divider(),
                            const SpaceHeight(8.0),
                            const Text(
                              'Total Payment',
                              style: TextStyle(
                                color: AppColors.primary,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SpaceHeight(12.0),
                            TextFormField(
                              controller: totalPriceController,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                hintText: 'Total Price',
                              ),
                            ),
                            const SpaceHeight(45.0),
                            Wrap(
                              spacing: 20.0, // Jarak horizontal antara widget
                              runSpacing:
                                  10.0, // Jarak vertikal antara baris widget
                              children: [
                                Button.filled(
                                  width: 150.0,
                                  onPressed: () {
                                    totalPriceController.text =
                                        totalPrice.currencyFormatRp;
                                    log("totalPriceController.text: ${totalPriceController.text}");
                                  },
                                  label: 'Money',
                                ),
                                Button.filled(
                                  width: 150.0,
                                  onPressed: () {
                                    totalPriceController.text =
                                        10000.currencyFormatRp;
                                  },
                                  label: 'Rp 10.000',
                                ),
                                Button.filled(
                                  width: 150.0,
                                  onPressed: () {
                                    totalPriceController.text =
                                        20000.currencyFormatRp;
                                  },
                                  label: 'Rp 20.000',
                                ),
                                Button.filled(
                                  width: 150.0,
                                  onPressed: () {
                                    totalPriceController.text =
                                        50000.currencyFormatRp;
                                  },
                                  label: 'Rp 50.000',
                                ),
                                Button.filled(
                                  width: 150.0,
                                  onPressed: () {
                                    totalPriceController.text =
                                        75000.currencyFormatRp;
                                  },
                                  label: 'Rp 75.000',
                                ),
                                ...List.generate(
                                  10,
                                  (index) {
                                    final nominal = (index + 1) * 100000;
                                    return Button.filled(
                                      width: 150.0,
                                      onPressed: () {
                                        totalPriceController.text =
                                            nominal.currencyFormatRp;
                                      },
                                      label: nominal.currencyFormatRp,
                                    );
                                  },
                                ),
                              ],
                            ),
                            const SpaceHeight(100.0),
                          ],
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: ColoredBox(
                          color: AppColors.white,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 24.0, vertical: 16.0),
                            child: Row(
                              children: [
                                Flexible(
                                  child: Button.outlined(
                                    onPressed: () => context.pop(),
                                    label: 'Cancel',
                                  ),
                                ),
                                const SpaceWidth(8.0),
                                Flexible(
                                  child: Button.filled(
                                    onPressed: () async {},
                                    label: 'Pay',
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
