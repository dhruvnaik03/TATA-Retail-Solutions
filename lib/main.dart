import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/product_provider.dart';
import 'providers/invoice_provider.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => ProductProvider()),
      ChangeNotifierProvider(create: (_) => InvoiceProvider()),
    ],
    child: GSTBillingApp(),
  ));
}

class GSTBillingApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GST Billing App',
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.teal),
      home: HomeScreen(),
    );
  }
}
