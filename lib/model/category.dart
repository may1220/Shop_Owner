import 'package:flutter/foundation.dart';

class Category with ChangeNotifier {
  final int categoryId;
  final String name;

  Category({this.categoryId, this.name});
}

final bookingCategory = Category(categoryId: 0, name: "Booking Status");

final serviceCategory = Category(categoryId: 1, name: "Service Status");

final customerCategory = Category(categoryId: 2, name: "Customer Status");


final categories = [
  bookingCategory,
  serviceCategory,
  customerCategory
];
