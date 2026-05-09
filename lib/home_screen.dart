import 'package:flutter/material.dart';
import 'package:gdg_campus_coffee/branches/presentation/view/branches_screen.dart';
import 'package:gdg_campus_coffee/market/presentation/view/market_screen.dart';
import 'package:gdg_campus_coffee/menu/presentation/view/menu_screen.dart';
import 'package:gdg_campus_coffee/recommendation/presentation/view/recommendation_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentPageIndex = 0;

  final List<String> _pageTitles = [
    "Menu",
    "Branches",
    "Market",
    "AI Suggestion",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Campus Coffee",
          style: TextStyle(
            fontSize: 26, // App ismi daha büyük
            fontWeight: FontWeight.w900,
          ),
        ),
        centerTitle: true, // Ortada hizalanmış
        elevation: 0,
      ),
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        selectedIndex: currentPageIndex,
        destinations: const <Widget>[
          NavigationDestination(
            icon: Icon(Icons.restaurant_menu_outlined),
            selectedIcon: Icon(Icons.restaurant_menu),
            label: 'Menu',
          ),
          NavigationDestination(
            icon: Icon(Icons.storefront_outlined),
            selectedIcon: Icon(Icons.storefront),
            label: 'Branches',
          ),
          NavigationDestination(
            icon: Icon(Icons.shopping_bag_outlined),
            selectedIcon: Icon(Icons.shopping_bag),
            label: 'Market',
          ),
          NavigationDestination(
            icon: Icon(Icons.auto_awesome_outlined),
            selectedIcon: Icon(Icons.auto_awesome),
            label: 'AI',
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Sekme adı barı (Sadece metni çevreleyecek büyüklükte, pill shape)
          Padding(
            padding: const EdgeInsets.only(top: 8.0, bottom: 16.0),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.secondary.withOpacity(0.15), // Hafif karamel arka plan
                borderRadius: BorderRadius.circular(24), // Oval (hap) şekli
                border: Border.all(
                  color: Theme.of(context).colorScheme.secondary.withOpacity(0.5),
                  width: 1,
                ),
              ),
              child: Text(
                _pageTitles[currentPageIndex],
                style: TextStyle(
                  fontSize: 16, // App isminden daha küçük
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary, // Koyu kahverengi
                  letterSpacing: 1.2,
                ),
              ),
            ),
          ),
          // Sayfa İçeriği
          Expanded(
            child: const <Widget>[
              MenuScreen(),
              BranchesScreen(),
              MarketScreen(),
              RecommendationScreen(),
            ][currentPageIndex],
          ),
        ],
      ),
    );
  }
}
