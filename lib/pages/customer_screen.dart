import 'package:flutter/material.dart';
import 'package:onthebest/models/customer.dart';
import 'package:onthebest/pages/add_customer_screen.dart';
import 'package:onthebest/widgets/customer_list_item.dart';

class CustomerScreen extends StatelessWidget {
  const CustomerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Clientes',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(icon: const Icon(Icons.search), onPressed: () {}),
          IconButton(icon: const Icon(Icons.sort), onPressed: () {}),
        ],
      ),
      body: ListView.separated(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        itemCount: mockCustomers.length,
        separatorBuilder: (context, index) =>
            const Divider(color: Color(0xFF2A2A2A), thickness: 1, height: 16),
        itemBuilder: (context, index) {
          final customer = mockCustomers[index];
          return CustomerListItem(customer: customer);
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddCustomerScreen()),
          );
        },
        icon: const Icon(Icons.person_add),
        label: const Text(
          'Novo Cliente',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

final List<Customer> mockCustomers = [
  Customer(
    name: 'Rafael Mendes',
    status: 'VIP',
    contactNumber: '(11) 98888-7777',
    lastPurchaseDate: '10/08/2026',
    totalSpent: '3.450,00',
  ),
  Customer(
    name: 'Lucas Almeida',
    status: 'Frequente',
    contactNumber: '(48) 99999-1111',
    lastPurchaseDate: '02/08/2026',
    totalSpent: '850,00',
  ),
  Customer(
    name: 'Thiago Costa',
    status: 'Novo',
    contactNumber: '(21) 97777-2222',
    lastPurchaseDate: '08/08/2026',
    totalSpent: '160,00',
  ),
  Customer(
    name: 'Fernando Souza',
    status: 'VIP',
    contactNumber: '(31) 95555-4444',
    lastPurchaseDate: '25/07/2026',
    totalSpent: '5.120,00',
  ),
];
