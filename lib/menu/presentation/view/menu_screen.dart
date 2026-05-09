import 'package:flutter/material.dart';
import 'package:gdg_campus_coffee/menu/presentation/mvvm/menu_view_model.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  late final MenuViewModel menuViewModel;

  @override
  void initState() {
    super.initState();
    menuViewModel = MenuViewModel();
    menuViewModel.fetchProducts();
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: menuViewModel,
      builder: (context, child) {
        if (menuViewModel.loading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (menuViewModel.products.isEmpty) {
          return const Center(
            child: Text("No coffee available right now. 😔"),
          );
        }
        return ListView.builder(
          padding: const EdgeInsets.all(16.0),
          itemCount: menuViewModel.products.length,
          itemBuilder: (context, index) {
            final product = menuViewModel.products[index];
            return Padding(
              padding: const EdgeInsets.only(bottom: 12.0),
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    children: [
                      Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.secondary.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(
                          Icons.local_cafe,
                          color: Theme.of(context).colorScheme.primary,
                          size: 32,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              product.name ?? '',
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              product.description ?? '',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey.shade600,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        "\$${product.price?.toStringAsFixed(2) ?? '0.00'}",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w900,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
