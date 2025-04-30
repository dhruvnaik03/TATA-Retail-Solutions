import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/product_provider.dart';
import '../widgets/product_tile.dart';
import 'invoice_screen.dart';
import 'history_screen.dart';
import '../models/product.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Product> cart = [];

  @override
  void initState() {
    super.initState();
    Provider.of<ProductProvider>(context, listen: false).loadProducts();
  }

  void addProductToCart(Product product) {
    setState(() {
      cart.add(product);
    });
  }

  void openInvoice() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => InvoiceScreen(cart: cart)),
    );
  }

  void openHistory() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => HistoryScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final products = Provider.of<ProductProvider>(context).products;

    return Scaffold(
      appBar: AppBar(title: Text('GST Billing')),
      body: ListView(
        children: products.map((p) => ProductTile(product: p, onAdd: () => addProductToCart(p))).toList(),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton.extended(onPressed: openInvoice, label: Text('Generate Bill')),
          SizedBox(height: 10),
          FloatingActionButton.extended(onPressed: openHistory, label: Text('History')),
        ],
      ),
    );
  }
}
