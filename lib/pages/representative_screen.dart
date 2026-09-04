import 'package:flutter/material.dart';
import 'package:onthebest/models/representative.dart';
import 'package:onthebest/pages/add_representative_screen.dart';
import 'package:onthebest/widgets/representative_list_item.dart';

class RepresentativesScreen extends StatelessWidget {
  const RepresentativesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Representantes',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [IconButton(icon: const Icon(Icons.search), onPressed: () {})],
      ),
      body: ListView.separated(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        itemCount: mockRepresentatives.length,
        separatorBuilder: (context, index) =>
            const Divider(color: Color(0xFF2A2A2A), thickness: 1, height: 16),
        itemBuilder: (context, index) {
          final rep = mockRepresentatives[index];
          return RepresentativeListItem(representative: rep);
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddRepresentativeScreen(),
            ),
          );
        },
        icon: const Icon(Icons.add),
        label: const Text(
          'Novo Representante',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

final List<Representative> mockRepresentatives = [
  Representative(
    storeName: 'Atacadão Têxtil Brás',
    repName: 'Carlos Mendes',
    address: 'Rua Bresser, 456 - Brás, São Paulo - SP',
    contactNumber: '(11) 91111-2222',
  ),
  Representative(
    storeName: 'Fábrica de Fios Sul',
    repName: 'Mariana Costa',
    address: 'Av. Industrial, 789 - Blumenau - SC',
    contactNumber: '(47) 93333-4444',
  ),
  Representative(
    storeName: 'Importadora Alfa Camisaria',
    repName: 'Roberto Almeida',
    address: 'Rua 25 de Março, 1010 - Centro, São Paulo - SP',
    contactNumber: '(11) 95555-6666',
  ),
  Representative(
    storeName: 'Jeans & Cia Distribuidora',
    repName: 'Fernanda Lima',
    address: 'Polo de Confecções, Lote 12 - Goiânia - GO',
    contactNumber: '(62) 98888-7777',
  ),
];
