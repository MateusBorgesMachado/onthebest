class AppTransaction {
  final String id;
  final String type;
  final String entityName;
  final String date;
  final String totalValue;
  final int itemCount;

  AppTransaction({
    required this.id,
    required this.type,
    required this.entityName,
    required this.date,
    required this.totalValue,
    required this.itemCount,
  });
}
