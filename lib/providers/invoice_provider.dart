import 'package:flutter/material.dart';
import '../models/invoice.dart';
import '../db/database_helper.dart';

class InvoiceProvider with ChangeNotifier {
  List<Invoice> _invoices = [];

  List<Invoice> get invoices => _invoices;

  Future<void> loadInvoices() async {
    _invoices = await DatabaseHelper.instance.fetchInvoices();
    notifyListeners();
  }

  Future<void> addInvoice(Invoice invoice) async {
    await DatabaseHelper.instance.insertInvoice(invoice);
    await loadInvoices();
  }
}
