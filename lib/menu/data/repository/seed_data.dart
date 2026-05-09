import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> uploadSampleData() async {
  final firestore = FirebaseFirestore.instance;
  final collection = firestore.collection('Menu');

  final sampleProducts = [
    {
      "name": "Espresso",
      "description": "Rich and bold single shot of espresso",
      "price": 3.50,
    },
    {
      "name": "Latte",
      "description": "Espresso with creamy steamed milk",
      "price": 4.50,
    },
    {
      "name": "Cappuccino",
      "description": "Espresso with steamed milk and thick foam",
      "price": 4.50,
    },
    {
      "name": "Caramel Macchiato",
      "description": "Vanilla-flavored syrup, milk, espresso, and caramel drizzle",
      "price": 5.00,
    },
    {
      "name": "Mocha",
      "description": "Espresso with mocha sauce, milk, and whipped cream",
      "price": 4.75,
    },
    {
      "name": "Americano",
      "description": "Espresso diluted with hot water",
      "price": 3.00,
    },
    {
      "name": "Cold Brew",
      "description": "Slow-steeped, incredibly smooth iced coffee",
      "price": 4.25,
    },
    {
      "name": "Iced Vanilla Latte",
      "description": "Espresso, milk, vanilla syrup over ice",
      "price": 4.75,
    }
  ];

  for (var product in sampleProducts) {
    await collection.add(product);
  }
}
