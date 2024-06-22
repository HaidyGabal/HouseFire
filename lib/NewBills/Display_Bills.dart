import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:flutter/services.dart' show rootBundle;

import '../Drawer/MyDrawerScreen.dart';
import '../LoSi/UserModel.dart';
import 'Bills_Model.dart';

class BillsPage extends StatefulWidget {
  final UserModel userModel;


  const BillsPage({Key? key, required this.userModel}) : super(key: key);

  @override
  _BillsPageState createState() => _BillsPageState();
}

class _BillsPageState extends State<BillsPage> {
  late Future<List<Bill>> _billsFuture;
  final DateFormat _dateFormat = DateFormat('MMM dd, yyyy');

  @override
  void initState() {
    super.initState();
    _billsFuture = _fetchBills();
  }

  Future<List<Bill>> _fetchBills() async {
    final response = await http.get(
      Uri.parse('https://companygas.runasp.net/api/Bills/GetBillByEmail?email=${widget.userModel.email}'),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${widget.userModel.token}',
      },
    );

    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = json.decode(response.body);
      List<Bill> bills = jsonResponse.map((data) => Bill.fromJson(data)).toList();
      return bills;
    } else {
      throw Exception('Failed to load bills');
    }
  }

  Future<void> _refreshBills() async {
    setState(() {
      _billsFuture = _fetchBills();
    });
  }

  Future<void> _generatePdf(Bill bill) async {
    final pdf = pw.Document();

    final imageLogo = pw.MemoryImage(
      (await rootBundle.load('assets/splash.png')).buffer.asUint8List(),
    );

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: pw.EdgeInsets.all(32),
        build: (pw.Context context) => [
          pw.Header(
            level: 0,
            child: pw.Text(
              'Bill Details',
              style: pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.bold),
            ),
          ),
          pw.Table.fromTextArray(
            headers: ['Field', 'Details'],
            data: [
              ['Bill ID', bill.billsId.toString()],
              ['Bill Date', _dateFormat.format(bill.billDate)],
              ['Invoice Value', '\$${bill.invoiceValue.toStringAsFixed(2)}'],
              ['Consumption Value', bill.consumptionValue.toStringAsFixed(2)],
              ['User Name', '${bill.firstName} ${bill.lastName}'],
              ['Phones', '${bill.phone1}, ${bill.phone2}'],
              ['Email', bill.email],
              ['National ID', bill.nationalId],
              ['Address', '${bill.street}, ${bill.city}, ${bill.region}'],
              [
                'Total Value',
                '\$${(bill.consumptionValue + bill.installmentValue).toStringAsFixed(2)}'
              ],
            ],
            border: pw.TableBorder.all(),
            headerStyle: pw.TextStyle(fontWeight: pw.FontWeight.bold),
            headerDecoration: pw.BoxDecoration(color: PdfColors.grey300),
            cellAlignment: pw.Alignment.centerLeft,
            cellHeight: 30,
            columnWidths: {
              0: pw.FlexColumnWidth(2),
              1: pw.FlexColumnWidth(4),
            },
          ),
          pw.Divider(),
          pw.Paragraph(
            text: 'Generated on: ${_dateFormat.format(DateTime.now())}',
            style: pw.TextStyle(fontSize: 14, fontStyle: pw.FontStyle.italic),
          ),
          pw.SizedBox(height: 10),
          pw.Align(
            alignment: pw.Alignment.bottomCenter,
            child: pw.Image(imageLogo, width: 300, height: 300),
          ), // Image at the bottom
        ],
      ),
    );

    await Printing.layoutPdf(
      onLayout: (PdfPageFormat format) async => pdf.save(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawerScreen(userModel: widget.userModel),
      appBar: AppBar(
        backgroundColor: Colors.grey.shade400,
        title: Text("My Bills"),
        centerTitle: true,
        toolbarHeight: 100.0,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(25),
            bottomRight: Radius.circular(25),
          ),
        ),
      ),
      body: FutureBuilder<List<Bill>>(
        future: _billsFuture,
        builder: (context, AsyncSnapshot<List<Bill>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Error: ${snapshot.error}'),
                  SizedBox(height: 8),
                  ElevatedButton(
                    onPressed: _refreshBills,
                    child: Text('Retry'),
                  ),
                ],
              ),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No bills available.'));
          } else {
            return RefreshIndicator(
              onRefresh: _refreshBills,
              child: ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  Bill bill = snapshot.data![index];
                  return Card(
                    margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    child: ExpansionTile(
                      title: Text('Bill ID: ${bill.billsId}'),
                      subtitle: Text('Invoice Value: ${bill.invoiceValue.toStringAsFixed(2)} EL'),
                      children: <Widget>[
                        ListTile(
                          title: Text('Bill Date: ${_dateFormat.format(bill.billDate)}'),
                        ),
                        ListTile(
                          title: Text('Consumption Value: ${bill.consumptionValue.toStringAsFixed(2)}'),
                        ),
                        ListTile(
                          title: Text('Installment Value: ${bill.installmentValue.toStringAsFixed(2)}'),
                        ),
                        ListTile(
                          title: Text('Username: ${widget.userModel.userName}'),
                        ),
                        ListTile(
                          title: Text('Full Name: ${bill.firstName} ${bill.lastName}'),
                        ),
                        ListTile(
                          title: Text('Phone1: ${bill.phone1}'),
                        ),
                        ListTile(
                          title: Text('Phone2: ${bill.phone2}'),
                        ),
                        ListTile(
                          title: Text('Email: ${bill.email}'),
                        ),
                        ListTile(
                          title: Text('National ID: ${bill.nationalId}'),
                        ),
                        // ListTile(
                        //   title: Text('User ID: ${bill.userId}'),
                        // ),
                        ListTile(
                          title: Text('Address: ${bill.street}, ${bill.city}, ${bill.region}'),
                        ),
                        ListTile(
                          title: Text('Total Value: ${(bill.consumptionValue + bill.installmentValue).toStringAsFixed(2)} EL'),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: ListTile(
                            title: ElevatedButton.icon(
                              onPressed: () {
                                _generatePdf(bill);
                              },
                              icon: Icon(Icons.picture_as_pdf, color: Colors.white),
                              label: Text(
                                'Download PDF',
                                style: TextStyle(color: Colors.white),
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.orange,
                              ),
                            ),
                          ),
                        ),
                        ListTile(

                        ),
                      ],
                    ),
                  );
                },
              ),
            );
          }
        },
      ),
    );
  }
}
