import 'package:flutter/material.dart';
import 'package:onthebest/models/app_transaction.dart';
import 'package:onthebest/pages/add_transaction_screen.dart';
import 'package:onthebest/widgets/transaction_list_item.dart';

class TransactionsScreen extends StatelessWidget {
  const TransactionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Vendas & Compras',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(icon: const Icon(Icons.search), onPressed: () {}),
          IconButton(icon: const Icon(Icons.filter_list), onPressed: () {}),
        ],
      ),
      body: ListView.separated(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        itemCount: mockTransactions.length,
        separatorBuilder: (context, index) =>
            const Divider(color: Color(0xFF2A2A2A), thickness: 1, height: 16),
        itemBuilder: (context, index) {
          final transaction = mockTransactions[index];
          return TransactionListItem(transaction: transaction);
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: const Color(0xFF5E42A6),
        foregroundColor: Colors.white,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddTransactionScreen(),
            ),
          );
        },
        icon: const Icon(Icons.add_shopping_cart),
        label: const Text(
          'Nova Transação',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

final List<AppTransaction> mockTransactions = [
  AppTransaction(
    id: 'PED-0042',
    type: 'Venda',
    entityName: 'Rafael Mendes',
    date: '11/08/2026',
    totalAmount: '450,00',
    itemCount: 3,
  ),
  AppTransaction(
    id: 'NF-1029',
    type: 'Compra',
    entityName: 'Atacadão Têxtil Brás',
    date: '10/08/2026',
    totalAmount: '2.150,00',
    itemCount: 45,
  ),
  AppTransaction(
    id: 'PED-0041',
    type: 'Venda',
    entityName: 'Lucas Almeida',
    date: '09/08/2026',
    totalAmount: '120,00',
    itemCount: 1,
  ),
  AppTransaction(
    id: 'NF-0884',
    type: 'Compra',
    entityName: 'Importadora Alfa',
    date: '05/08/2026',
    totalAmount: '850,00',
    itemCount: 15,
  ),
];
