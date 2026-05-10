import 'package:flutter/material.dart';
import 'package:gdg_campus_coffee/cart/domain/entity/cart_item.dart';
import 'package:gdg_campus_coffee/cart/presentation/mvvm/cart_view_model.dart';
import 'package:gdg_campus_coffee/menu/domain/entity/product.dart';
import 'package:gdg_campus_coffee/menu/presentation/mvvm/menu_view_model.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  late final MenuViewModel menuViewModel;
  late final CartViewModel cartViewModel;
  final TextEditingController _searchController = TextEditingController();
  final List<String> _categories = [
    'All',
    'Espresso',
    'Americano',
    'Latte',
    'Cappuccino',
  ];
  int _selectedCategoryIndex = 0;

  @override
  void initState() {
    super.initState();
    menuViewModel = MenuViewModel();
    menuViewModel.fetchProducts();
    cartViewModel = CartViewModel();
  }

  List<Product> get _filteredProducts {
    final query = _searchController.text.toLowerCase().trim();
    final selectedCategory = _categories[_selectedCategoryIndex];

    return menuViewModel.products.where((product) {
      final name = (product.name ?? '').toLowerCase();
      final description = (product.description ?? '').toLowerCase();
      final matchesQuery =
          query.isEmpty || name.contains(query) || description.contains(query);
      final matchesCategory =
          selectedCategory == 'All' ||
          name.contains(selectedCategory.toLowerCase());
      return matchesQuery && matchesCategory;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ListenableBuilder(
      listenable: menuViewModel,
      builder: (context, child) {
        if (menuViewModel.loading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (menuViewModel.error != null) {
          return Center(
            child: Text(
              "Menü yüklenemedi: ${menuViewModel.error}",
              textAlign: TextAlign.center,
            ),
          );
        }

        final products = _filteredProducts;
        return SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20.0),
                decoration: BoxDecoration(
                  color: theme.colorScheme.primary,
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Find the best coffee for you',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(18),
                            ),
                            child: TextField(
                              controller: _searchController,
                              onChanged: (_) => setState(() {}),
                              style: const TextStyle(color: Colors.black87),
                              decoration: const InputDecoration(
                                hintText: 'Find your coffee...',
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 14,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        ElevatedButton(
                          onPressed: () => setState(() {}),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: theme.colorScheme.secondary,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18),
                            ),
                            padding: const EdgeInsets.all(14),
                          ),
                          child: const Icon(Icons.search, color: Colors.white),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: List.generate(_categories.length, (index) {
                    final isSelected = index == _selectedCategoryIndex;
                    return Padding(
                      padding: const EdgeInsets.only(right: 10.0),
                      child: ChoiceChip(
                        label: Text(_categories[index]),
                        selected: isSelected,
                        onSelected: (_) {
                          setState(() {
                            _selectedCategoryIndex = index;
                          });
                        },
                        selectedColor: theme.colorScheme.primary,
                        backgroundColor: theme.colorScheme.surface,
                        labelStyle: TextStyle(
                          color: isSelected
                              ? Colors.white
                              : theme.colorScheme.onSurface,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                    );
                  }),
                ),
              ),
              const SizedBox(height: 20),
              if (products.isEmpty)
                Center(
                  child: Column(
                    children: const [
                      Icon(
                        Icons.sentiment_dissatisfied,
                        size: 52,
                        color: Colors.grey,
                      ),
                      SizedBox(height: 12),
                      Text(
                        'No matching coffee found.',
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                )
              else
                Column(
                  children: List.generate(products.length, (index) {
                    final product = products[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 16.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(24),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              blurRadius: 18,
                              offset: const Offset(0, 8),
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: 76,
                                height: 76,
                                decoration: BoxDecoration(
                                  color: theme.colorScheme.secondary
                                      .withOpacity(0.18),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Icon(
                                  Icons.local_cafe,
                                  color: theme.colorScheme.primary,
                                  size: 36,
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
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      product.description ?? '',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.grey.shade600,
                                      ),
                                      maxLines: 3,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    const SizedBox(height: 12),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "\$${product.price?.toStringAsFixed(2) ?? '0.00'}",
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w900,
                                            color: theme.colorScheme.primary,
                                          ),
                                        ),
                                        ElevatedButton(
                                          onPressed: () {
                                            final cartItem = CartItem(
                                              id: '${product.name}_${DateTime.now().millisecondsSinceEpoch}',
                                              name:
                                                  product.name ??
                                                  'Unknown Product',
                                              description: product.description,
                                              price: product.price,
                                              type: 'menu',
                                            );
                                            cartViewModel.addItem(cartItem);
                                            ScaffoldMessenger.of(
                                              context,
                                            ).showSnackBar(
                                              SnackBar(
                                                content: Text(
                                                  '${product.name} added to cart!',
                                                ),
                                                duration: const Duration(
                                                  seconds: 2,
                                                ),
                                              ),
                                            );
                                          },
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor:
                                                theme.colorScheme.secondary,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(16),
                                            ),
                                          ),
                                          child: const Text('Add to Cart'),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
                ),
            ],
          ),
        );
      },
    );
  }
}
