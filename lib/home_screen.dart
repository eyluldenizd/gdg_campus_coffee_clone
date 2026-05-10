import 'package:flutter/material.dart';
import 'package:gdg_campus_coffee/branches/presentation/view/branches_screen.dart';
import 'package:gdg_campus_coffee/cart/presentation/mvvm/cart_view_model.dart';
import 'package:gdg_campus_coffee/cart/presentation/view/cart_screen.dart';
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
  late final CartViewModel cartViewModel;

  final List<String> _pageTitles = [
    "Menu",
    "Branches",
    "Market",
    "AI Suggestion",
  ];

  @override
  void initState() {
    super.initState();
    cartViewModel = CartViewModel();
  }

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
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: ListenableBuilder(
              listenable: cartViewModel,
              builder: (context, child) {
                final itemCount = cartViewModel.itemCount;
                return Stack(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.shopping_cart_outlined, size: 28),
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const CartScreen(),
                          ),
                        );
                      },
                      style: IconButton.styleFrom(
                        backgroundColor: Theme.of(
                          context,
                        ).colorScheme.surface.withOpacity(0.1),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                    if (itemCount > 0)
                      Positioned(
                        right: 0,
                        top: 0,
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.secondary,
                            shape: BoxShape.circle,
                          ),
                          constraints: const BoxConstraints(
                            minWidth: 20,
                            minHeight: 20,
                          ),
                          child: Text(
                            itemCount.toString(),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                  ],
                );
              },
            ),
          ),
        ],
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
            label: 'Şubeler',
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
      body: IndexedStack(
        index: currentPageIndex,
        children: const [
          MenuScreen(),
          BranchesScreen(),
          MarketScreen(),
          RecommendationScreen(),
        ],
      ),
    );
  }
}
