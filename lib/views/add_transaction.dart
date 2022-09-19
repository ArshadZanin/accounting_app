import 'dart:io';

import 'package:accounting_app/controllers/add_transaction_controller.dart';
import 'package:accounting_app/core/google_sheets_api.dart';
import 'package:accounting_app/core/services/receipt_pdf.dart';
import 'package:accounting_app/core/services/telegram_bot_services.dart';
import 'package:accounting_app/models/item_model.dart';
import 'package:accounting_app/models/transaction_model.dart';
import 'package:accounting_app/views/transactions.dart';
import 'package:accounting_app/widgets/text.dart';
import 'package:accounting_app/widgets/text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';

class AddTransaction extends StatefulWidget {
  final int newNo;
  const AddTransaction({
    Key? key,
    required this.newNo,
  }) : super(key: key);

  @override
  State<AddTransaction> createState() => _AddTransactionState();
}

class _AddTransactionState extends State<AddTransaction> {
  final controller = Get.put(AddTransactionController());
  final siNo = TextEditingController();
  final date = TextEditingController(
      text:
          '${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}');
  final tnr = TextEditingController();
  final cusTNR = TextEditingController();
  final name = TextEditingController();
  final lpoNo = TextEditingController();

  @override
  void initState() {
    siNo.text = widget.newNo.toString();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color.fromARGB(255, 196, 183, 252),
        body: Column(
          children: [
            _buildHeaderItem(),
            _buildBasicDetailsPanel(),
            Expanded(
              child:
                  GetBuilder<AddTransactionController>(builder: (controller) {
                return SingleChildScrollView(
                  child: Column(children: [
                    ...List.generate(
                        controller.transaction.items!.length,
                        (index) => _buildTransactionCard(
                            controller.transaction.items![index])),
                    _buildAddTransactionCard(),
                  ]),
                );
              }),
            ),
            Divider(
              color: Colors.indigo,
              height: 0,
              thickness: 1,
            ),
            _buildTotalAmount(),
          ],
        ),
        floatingActionButton: _buildSaveButton(),
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
              fontSize: 25,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBasicDetailsPanel() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: RTextField(
                  text: 'No.',
                  controller: siNo,
                  color: Colors.red[700]!,
                ),
              ),
              SizedBox(
                width: 5,
              ),
              Expanded(
                child: RTextField(
                  text: 'Date',
                  controller: date,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Expanded(
                child: RTextField(
                  text: 'TNR',
                  controller: tnr,
                ),
              ),
              SizedBox(
                width: 5,
              ),
              Expanded(
                child: RTextField(
                  text: 'Cust.TNR',
                  controller: cusTNR,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Expanded(
                child: RTextField(
                  text: 'Mr./M/s',
                  controller: name,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Expanded(
                child: RTextField(
                  text: 'LPO No.',
                  controller: lpoNo,
                  keyboardType: TextInputType.number,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTransactionCard(Items item) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 2),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.indigo),
          color: Color.fromARGB(255, 196, 183, 252),
          borderRadius: BorderRadius.circular(15),
        ),
        width: double.infinity,
        height: 100,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            RText(item.description!),
            RText(item.amount!.toString()),
          ],
        ),
      ),
    );
  }

  Widget _buildAddTransactionCard() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 2),
      child: InkWell(
        onTap: () {
          showAddItem();
        },
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.indigo),
            color: Color.fromARGB(255, 196, 183, 252),
            borderRadius: BorderRadius.circular(15),
          ),
          width: double.infinity,
          height: 100,
          child: Center(
            child: Icon(Icons.add),
          ),
        ),
      ),
    );
  }

  Widget _buildTotalAmount() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: RText(
          'Total: ${controller.transaction.items!.isEmpty ? 0 : controller.transaction.items!.map((e) => e.amount).toList().reduce((a, b) => a! + b!)}'),
    );
  }

  Widget _buildSaveButton() {
    return FloatingActionButton(
      backgroundColor: Colors.indigo,
      onPressed: () async {
        final transactionModel = controller.transaction.copyWith(
          no: siNo.text,
          date: date.text,
          tnr: tnr.text,
          cusTnr: cusTNR.text,
          name: name.text,
          LpnNo: lpoNo.text,
          total: controller.transaction.items!
              .map((e) => e.amount)
              .toList()
              .reduce((a, b) => a! + b!)
              .toString(),
        );
        await GoogleSheetsApi.insertRow([transactionModel.toJson()]);
        await TelegramBotServices.sendMessage(
            '${transactionModel.toJson().toString().replaceAll('{', '').replaceAll('}', '').replaceAll(',', '\n')}');
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
            decoration: BoxDecoration(border: Border.all()),
            child: TextButton(
              onPressed: () async {
                File pdf = await RecieptPDF.createReciept(transactionModel);
                Share.shareFiles([pdf.path], text: 'Receipt');
                Get.offAll(Transactions());
              },
              child: RText('Share'),
            ),
          ),
          cancel: Container(
            padding: EdgeInsets.symmetric(
              horizontal: 2,
              vertical: 2,
            ),
            decoration: BoxDecoration(border: Border.all()),
            child: TextButton(
              onPressed: () {
                Get.offAll(Transactions());
              },
              child: RText('Skip'),
            ),
          ),
        );
      },
      child: Icon(Icons.download_done_rounded),
    );
  }

  void showAddItem() {
    final desc = TextEditingController();
    final qty = TextEditingController();
    final unitPrice = TextEditingController();
    final netAmount = TextEditingController();
    Get.defaultDialog(
      title: 'Add Item',
      barrierDismissible: false,
      content: SizedBox(
        width: MediaQuery.of(context).size.width - 50,
        child: Column(
          children: [
            RTextField(text: 'Desc', controller: desc),
            SizedBox(
              height: 2,
            ),
            RTextField(
              text: 'Qty',
              controller: qty,
              keyboardType: TextInputType.number,
            ),
            SizedBox(
              height: 2,
            ),
            RTextField(
              text: 'Unit Price',
              controller: unitPrice,
              keyboardType: TextInputType.number,
            ),
            SizedBox(
              height: 2,
            ),
            RTextField(
              text: 'Net Amount',
              controller: netAmount,
              keyboardType: TextInputType.number,
            ),
          ],
        ),
      ),
      confirm: TextButton(
        onPressed: () {
          final item = Items(
            description: desc.text,
            qty: int.tryParse(qty.text),
            unitPrice: int.tryParse(unitPrice.text),
            netAmount: int.tryParse(netAmount.text),
            amount: int.tryParse(netAmount.text),
          );
          controller.transaction.items!.add(item);
          controller.update();
          Get.back();
        },
        child: RText(
          'Save',
          fontSize: 18,
          color: Colors.indigo,
        ),
      ),
      cancel: TextButton(
        onPressed: Get.back,
        child: RText(
          'Cancel',
          fontSize: 18,
        ),
      ),
    );
  }
}
