import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> uploadSampleData() async {
  final firestore = FirebaseFirestore.instance;

  // Menu Products
  final menuCollection = firestore.collection('Menu');
  final sampleMenuProducts = [
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
      "description":
          "Vanilla-flavored syrup, milk, espresso, and caramel drizzle",
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
    },
  ];

  for (var product in sampleMenuProducts) {
    await menuCollection.add(product);
  }

  // Branches
  final branchesCollection = firestore.collection('branches');
  final sampleBranches = [
    {"name": "Downtown Campus Coffee", "address": "123 Main Street, Downtown"},
    {
      "name": "North Campus Café",
      "address": "456 University Ave, North Campus",
    },
    {
      "name": "Student Center Brew",
      "address": "789 College Road, Student Center",
    },
    {
      "name": "Library Corner Coffee",
      "address": "321 Book Lane, Library Building",
    },
  ];

  for (var branch in sampleBranches) {
    await branchesCollection.add(branch);
  }

  // Market Products
  final marketCollection = firestore.collection('market');
  final sampleMarketProducts = [
    {
      "name": "Ethiopian Yirgacheffe",
      "description": "Premium single-origin kahve çekirdeği, çiçeksi aroma",
      "price": 45.00,
      "category": "Coffee Beans",
    },
    {
      "name": "Premium Thermos",
      "description": "Çift duvarlı ısı yalıtımlı termos, 500ml",
      "price": 89.99,
      "category": "Accessories",
    },
    {
      "name": "Coffee Mug",
      "description": "Seramik kahve kupası, 300ml",
      "price": 25.00,
      "category": "Merchandise",
    },
    {
      "name": "Colombian Geisha",
      "description": "World's most expensive coffee beans with complex flavors",
      "price": 150.00,
      "category": "Coffee Beans",
    },
    {
      "name": "Manual Coffee Grinder",
      "description": "Precision grinder for consistent particle size",
      "price": 49.99,
      "category": "Equipment",
    },
    {
      "name": "Coffee T-Shirt",
      "description": "Cool coffee-themed t-shirt, 100% cotton",
      "price": 19.99,
      "category": "Merchandise",
    },
  ];

  for (var product in sampleMarketProducts) {
    await marketCollection.add(product);
  }

  // Recommendations (referencing menu and market products)
  final recommendationsCollection = firestore.collection('recommendations');
  final sampleRecommendations = [
    {
      "id": "rec_1",
      "name": "Cappuccino",
      "description": "Espresso with steamed milk and thick foam",
      "reason": "Perfect for morning energy boost",
      "price": 4.50,
      "type": "menu",
    },
    {
      "id": "rec_2",
      "name": "Ethiopian Yirgacheffe",
      "description": "Premium single-origin kahve çekirdeği, çiçeksi aroma",
      "reason": "Best for home brewing",
      "price": 45.00,
      "type": "market",
    },
    {
      "id": "rec_3",
      "name": "Cold Brew",
      "description": "Slow-steeped, incredibly smooth iced coffee",
      "reason": "Summer favorite",
      "price": 4.25,
      "type": "menu",
    },
    {
      "id": "rec_4",
      "name": "Latte",
      "description": "Espresso with creamy steamed milk",
      "reason": "Great for relaxation",
      "price": 4.50,
      "type": "menu",
    },
    {
      "id": "rec_5",
      "name": "Manual Coffee Grinder",
      "description": "Precision grinder for consistent particle size",
      "reason": "Essential for coffee enthusiasts",
      "price": 49.99,
      "type": "market",
    },
  ];

  for (var recommendation in sampleRecommendations) {
    await recommendationsCollection.add(recommendation);
  }

  print("✅ All sample data uploaded successfully!");
}
