import 'package:flutter/material.dart';
import 'package:onthebest/models/Product.dart';
import 'package:onthebest/pages/add_product_screen.dart';
import 'package:onthebest/widgets/product_list_item.dart';

class MainInventoryScreen extends StatefulWidget {
  const MainInventoryScreen({super.key});

  @override
  State<MainInventoryScreen> createState() => _MainInventoryScreenState();
}

class _MainInventoryScreenState extends State<MainInventoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Estoque',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.account_circle_outlined),
            onPressed: () {},
          ),
        ],
      ),

      body: ListView.separated(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        itemCount: mockProducts.length,
        separatorBuilder: (context, index) =>
            const Divider(color: Color(0xFF2A2A2A), thickness: 1, height: 16),
        itemBuilder: (context, index) {
          final product = mockProducts[index];
          return ProductListItem(product: product);
        },
      ),

      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: const Color(0xFFFFCC00),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddProductScreen()),
          );
        },
        icon: const Icon(Icons.add, color: Colors.black),
        label: const Text(
          'Adicionar Produto',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  final List<Product> mockProducts = [
    Product(
      name: 'Camisa Social Slim Fit',
      category: 'Roupas',
      subcategory: 'Camisas',
      costPrice: '45,00',
      finalPrice: '120,00',
      lastPurchaseDate: '01/08/2026',
      stockQuantity: 45,
    ),
    Product(
      name: 'Calça Sarja Caqui',
      category: 'Roupas',
      subcategory: 'Calças',
      costPrice: '60,00',
      finalPrice: '160,00',
      lastPurchaseDate: '15/07/2026',
      stockQuantity: 28,
    ),
    Product(
      name: 'Terno Azul Marinho',
      category: 'Roupas',
      subcategory: 'Alfaiataria',
      costPrice: '250,00',
      finalPrice: '750,00',
      lastPurchaseDate: '20/06/2026',
      stockQuantity: 12,
    ),
    Product(
      name: 'Camiseta Básica Preta',
      category: 'Roupas',
      subcategory: 'Camisetas',
      costPrice: '18,50',
      finalPrice: '50,00',
      lastPurchaseDate: '05/08/2026',
      stockQuantity: 120,
    ),
    Product(
      name: 'Jaqueta de Couro Sintético',
      category: 'Roupas',
      subcategory: 'Inverno',
      costPrice: '110,00',
      finalPrice: '290,00',
      lastPurchaseDate: '10/05/2026',
      stockQuantity: 8,
    ),
  ];
}
