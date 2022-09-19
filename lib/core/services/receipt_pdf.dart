import 'dart:io';

import 'package:accounting_app/models/item_model.dart';
import 'package:accounting_app/models/transaction_model.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class RecieptPDF {
  static Future<File> createReciept(Transaction transaction) async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Container(
            child: pw.Column(
              children: [
                _buildHeaderItem(),
                pw.Divider(),
                _buildTransactionDetailsItem(transaction),
                _buildNameDetailsItem(transaction),
                pw.Divider(),
                _buildTableItem(transaction.items ?? []),
                _buildTotalItem(transaction),
              ],
            ),
          );
        },
      ),
    );

    Directory tempDir = await getTemporaryDirectory();
    String tempPath = tempDir.path;
    final file = File("$tempPath/receipt1.pdf");
    await file.writeAsBytes(await pdf.save());
    // OpenFile.open(file.path);
    return file;
  }

  static pw.Widget _buildHeaderItem() {
    return pw.Padding(
      padding: const pw.EdgeInsets.all(16.0),
      child: pw.Row(
        children: [
          pw.Expanded(
            child: pw.Text(
              'Al Ramool Gifts Trading',
              style: pw.TextStyle(
                fontWeight: pw.FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ),
          pw.VerticalDivider(thickness: 1, width: 2),
          pw.Column(
            children: [
              pw.Text(
                'Mob: +971 56 7717 880',
                style: pw.TextStyle(
                  fontSize: 13,
                ),
              ),
              pw.Text(
                'Mob: +971 55 6590 370',
                style: pw.TextStyle(
                  fontSize: 13,
                ),
              ),
              pw.Text(
                'Al Madam, Sharjah-U.A.E',
                style: pw.TextStyle(
                  fontSize: 13,
                ),
              ),
              pw.Text(
                'Email: ramoolgift@gmail.com',
                style: pw.TextStyle(
                  fontSize: 13,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  static pw.Widget _buildTransactionDetailsItem(Transaction transaction) {
    return pw.Padding(
      padding:
          const pw.EdgeInsets.only(top: 16, left: 16, right: 16, bottom: 5),
      child: pw.Row(
        children: [
          pw.Expanded(
            child: pw.Column(
              children: [
                pw.Container(
                  width: 200,
                  padding: pw.EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: pw.BoxDecoration(
                    border: pw.Border.all(),
                    borderRadius: pw.BorderRadius.circular(5),
                  ),
                  child: pw.Text('No.: ${transaction.no}'),
                ),
                pw.SizedBox(height: 5),
                pw.Container(
                  width: 200,
                  padding: pw.EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: pw.BoxDecoration(
                    border: pw.Border.all(),
                    borderRadius: pw.BorderRadius.circular(5),
                  ),
                  child: pw.Text('TNR: ${transaction.tnr}'),
                ),
              ],
            ),
          ),
          pw.Expanded(
            child: pw.Column(
              children: [
                // pw.Text('Date: ${transaction.date}'),
                // pw.Divider(),
                pw.Text('TAX INVOICE'),
              ],
            ),
          ),
          pw.Expanded(
            child: pw.Column(
              children: [
                pw.Container(
                  width: 200,
                  padding: pw.EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: pw.BoxDecoration(
                    border: pw.Border.all(),
                    borderRadius: pw.BorderRadius.circular(5),
                  ),
                  child: pw.Text('Date: ${transaction.date}'),
                ),
                pw.SizedBox(height: 5),
                pw.Container(
                  width: 200,
                  padding: pw.EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: pw.BoxDecoration(
                    border: pw.Border.all(),
                    borderRadius: pw.BorderRadius.circular(5),
                  ),
                  child: pw.Text('Cust.TNR: ${transaction.cusTnr}'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  static pw.Widget _buildNameDetailsItem(Transaction transaction) {
    return pw.Padding(
      padding:
          const pw.EdgeInsets.only(top: 0, left: 16, right: 16, bottom: 16),
      child: pw.Row(
        children: [
          pw.Expanded(
            child: pw.Container(
              width: 200,
              padding: pw.EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: pw.BoxDecoration(
                border: pw.Border.all(),
                borderRadius: pw.BorderRadius.circular(5),
              ),
              child: pw.Text('Mr./M/s.: ${transaction.name}',
                  overflow: pw.TextOverflow.clip),
            ),
          ),
          pw.SizedBox(width: 5),
          pw.Expanded(
            child: pw.Container(
              width: 200,
              padding: pw.EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: pw.BoxDecoration(
                border: pw.Border.all(),
                borderRadius: pw.BorderRadius.circular(5),
              ),
              child: pw.Text('LPN No.: ${transaction.LpnNo}'),
            ),
          ),
        ],
      ),
    );
  }

  static pw.Widget _buildTableItem(List<Items> items) {
    return pw.Padding(
      padding: const pw.EdgeInsets.all(16),
      child: pw.Container(
        decoration: pw.BoxDecoration(
          border: pw.Border.all(),
        ),
        child: pw.Column(
          children: [
            _buildRowItem(
              'S.N.',
              'Description',
              'Qty.',
              'Unit Price',
              'Net Amount',
              'VAT 5%',
              'Total Amount',
            ),
            ...List.generate(
              items.length,
              (index) => _buildRowItem(
                '${index + 1}',
                '${items[index].description}',
                '${items[index].qty}',
                '${items[index].unitPrice}',
                '${items[index].netAmount}',
                '${items[index].vat}',
                '${items[index].amount}',
              ),
            )
          ],
        ),
      ),
    );
  }

  static pw.Widget _buildRowItem(
    String sn,
    String desc,
    String qty,
    String unitPrice,
    String netamount,
    String vat,
    String total,
  ) {
    return pw.Row(
      children: [
        pw.Expanded(
          flex: 2,
          child: pw.Container(
            alignment: pw.Alignment.center,
            padding: pw.EdgeInsets.symmetric(vertical: 4),
            decoration: pw.BoxDecoration(
              border: pw.Border.all(),
            ),
            child: pw.Text(sn,
                overflow: pw.TextOverflow.clip,
                style: pw.TextStyle(fontSize: 10)),
          ),
        ),
        pw.Expanded(
          flex: 4,
          child: pw.Container(
            alignment: pw.Alignment.center,
            padding: pw.EdgeInsets.symmetric(vertical: 4),
            decoration: pw.BoxDecoration(
              border: pw.Border.all(),
            ),
            child: pw.Text(desc, style: pw.TextStyle(fontSize: 10)),
          ),
        ),
        pw.Expanded(
          flex: 2,
          child: pw.Container(
            alignment: pw.Alignment.center,
            padding: pw.EdgeInsets.symmetric(vertical: 4),
            decoration: pw.BoxDecoration(
              border: pw.Border.all(),
            ),
            child: pw.Text(qty, style: pw.TextStyle(fontSize: 10)),
          ),
        ),
        pw.Expanded(
          flex: 2,
          child: pw.Container(
            alignment: pw.Alignment.center,
            padding: pw.EdgeInsets.symmetric(vertical: 4),
            decoration: pw.BoxDecoration(
              border: pw.Border.all(),
            ),
            child: pw.Text(unitPrice, style: pw.TextStyle(fontSize: 10)),
          ),
        ),
        pw.Expanded(
          flex: 3,
          child: pw.Container(
            alignment: pw.Alignment.center,
            padding: pw.EdgeInsets.symmetric(vertical: 4),
            decoration: pw.BoxDecoration(
              border: pw.Border.all(),
            ),
            child: pw.Text(netamount, style: pw.TextStyle(fontSize: 10)),
          ),
        ),
        pw.Expanded(
          flex: 2,
          child: pw.Container(
            alignment: pw.Alignment.center,
            padding: pw.EdgeInsets.symmetric(vertical: 4),
            decoration: pw.BoxDecoration(
              border: pw.Border.all(),
            ),
            child: pw.Text(vat, style: pw.TextStyle(fontSize: 10)),
          ),
        ),
        pw.Expanded(
          flex: 3,
          child: pw.Container(
            alignment: pw.Alignment.center,
            padding: pw.EdgeInsets.symmetric(vertical: 4),
            decoration: pw.BoxDecoration(
              border: pw.Border.all(),
            ),
            child: pw.Text(total, style: pw.TextStyle(fontSize: 10)),
          ),
        ),
      ],
    );
  }

  static pw.Widget _buildTotalItem(Transaction transaction) {
    return pw.Padding(
      padding:
          const pw.EdgeInsets.only(top: 0, left: 16, right: 16, bottom: 16),
      child: pw.Row(
        children: [
          pw.Expanded(
            child: pw.Container(
              width: 200,
              padding: pw.EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: pw.BoxDecoration(
                border: pw.Border.all(),
                borderRadius: pw.BorderRadius.circular(5),
              ),
              child: pw.Text('Total Dhs: ', overflow: pw.TextOverflow.clip),
            ),
          ),
          pw.Expanded(
            child: pw.Container(
              width: 200,
              padding: pw.EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: pw.BoxDecoration(
                border: pw.Border.all(),
                borderRadius: pw.BorderRadius.circular(5),
              ),
              child: pw.Text('Grand Total: ${transaction.total}',
                  textAlign: pw.TextAlign.right),
            ),
          ),
        ],
      ),
    );
  }
}
