class ItemModel {

  String name;
  int quantity;
  String category;
  int usedCount;

  DateTime expiryDate;

  ItemModel({
    required this.name,
    required this.quantity,
    required this.category,
    required this.usedCount,
    required this.expiryDate,
  });

  bool get isLowStock => quantity <= 5;

  String get expiryText {

    final days =
        expiryDate
            .difference(
            DateTime.now())
            .inDays;

    if (days <= 0) {
      return "Expired";
    }

    if (days < 30) {
      return "Expires in $days days";
    }

    final weeks =
        (days / 7).floor();

    return "Expires in $weeks weeks";
  }
}