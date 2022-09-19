import 'dart:io';

import 'package:accounting_app/controllers/transactions_controller.dart';
import 'package:accounting_app/core/services/receipt_pdf.dart';
import 'package:accounting_app/views/add_transaction.dart';
import 'package:accounting_app/widgets/text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';

class Transactions extends StatefulWidget {
  Transactions({Key? key}) : super(key: key);

  @override
  State<Transactions> createState() => _TransactionsState();
}

class _TransactionsState extends State<Transactions> {
  final controller = Get.put(TransactionsController());

  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      controller.initialize();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: RefreshIndicator(
        onRefresh: () async => controller.initialize(),
        child: Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                _buildHeaderItem(),
                Divider(
                  color: Colors.indigo,
                ),
                Expanded(
                  child:
                      GetBuilder<TransactionsController>(builder: (controller) {
                    return ListView.builder(
                      itemCount: controller.transactionList.length,
                      itemBuilder: (context, index) {
                        return Card(
                          child: ListTile(
                            onTap: () async {
                              await Get.defaultDialog(
                                title: 'Share Receipt',
                                barrierDismissible: false,
                                content: SizedBox(
                                  height: 70,
                                  child: RText(
                                    'Do You Want To Share Receipt?',
                                    fontSize: 15,
                                  ),
                                ),
                                confirm: Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 2,
                                    vertical: 2,
                                  ),
                                  decoration:
                                      BoxDecoration(border: Border.all()),
                                  child: TextButton(
                                    onPressed: () async {
                                      File pdf = await RecieptPDF.createReciept(
                                          controller.transactionList[index]);
                                      Share.shareFiles([pdf.path],
                                          text: 'Receipt');
                                      Get.back();
                                    },
                                    child: RText('Share'),
                                  ),
                                ),
                                cancel: Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 2,
                                    vertical: 2,
                                  ),
                                  decoration:
                                      BoxDecoration(border: Border.all()),
                                  child: TextButton(
                                    onPressed: Get.back,
                                    child: RText('Skip'),
                                  ),
                                ),
                              );
                            },
                            title: RText(
                              '${controller.transactionList[index].name}',
                              textAlign: TextAlign.left,
                            ),
                            subtitle: RText(
                              'No: ${controller.transactionList[index].no}',
                              fontSize: 12,
                              color: Colors.red,
                              textAlign: TextAlign.left,
                            ),
                            trailing: RText(
                                '${controller.transactionList[index].total}'),
                          ),
                        );
                      },
                    );
                  }),
                ),
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () async {
              await Get.to(AddTransaction(
                newNo: controller.transactionList.isEmpty
                    ? 10001
                    : int.tryParse(controller.transactionList.first.no!)! + 1,
              ));
              controller.initialize();
            },
            backgroundColor: Colors.indigo,
            child: Icon(Icons.add),
          ),
        ),
      ),
    );
  }

  Widget _buildHeaderItem() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          Image.asset(
            'assets/images/balloons.png',
            width: 80,
            height: 80,
          ),
          Expanded(
            child: RText(
              'Al Ramool Gifts Trading',
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ],
      ),
    );
  }
}
