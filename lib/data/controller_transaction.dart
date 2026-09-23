import 'package:onthebest/models/app_transaction.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ControllerTransaction {
  static Future<void> insertTransaction(AppTransaction transaction) async {
    final supabase = Supabase.instance.client;

    final response = await supabase.from('transactions').insert({
      'entity_name': transaction.entityName,
      'type': transaction.type,
      'item_count': transaction.itemCount,
      'total_value': transaction.totalValue,
      'date': transaction.date.toString(),
    });

    if (response.error != null) {
      throw Exception('Failed to insert transaction: ${response.error!.message}');
    }
  }

  static Future<List<AppTransaction>> getTransactions() async {
    final supabase = Supabase.instance.client;

    final response = await supabase.from('transactions').select();

    if (response.isEmpty) {
      throw Exception('Failed to fetch transactions: No data found');
    }

    return response.map((item) {
      return AppTransaction(
        id: item['id'].toString(),
        type: item['type'],
        entityName: item['entity_name'],
        date: item['date'],
        totalValue: item['total_value'],
        itemCount: item['item_count'],
      );
    }).toList();
  }

  static Future<void> deleteTransaction(String id) async {
    final supabase = Supabase.instance.client;

    final response = await supabase.from('transactions').delete().eq('id', id);

    if (response.isEmpty) {
      throw Exception('Failed to delete transaction: No data found');
    }
  }

  static Future<void> updateTransaction(AppTransaction transaction) async {
    final supabase = Supabase.instance.client;

    final response = await supabase.from('transactions').update({
      'entity_name': transaction.entityName,
      'type': transaction.type,
      'item_count': transaction.itemCount,
      'total_value': transaction.totalValue,
      'date': transaction.date.toString(),
    }).eq('id', transaction.id);

    if (response.isEmpty) {
      throw Exception('Failed to update transaction: No data found');
    }
  }
}