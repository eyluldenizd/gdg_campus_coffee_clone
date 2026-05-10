import 'package:flutter/material.dart';
import 'package:gdg_campus_coffee/cart/domain/entity/cart_item.dart';
import 'package:gdg_campus_coffee/cart/presentation/mvvm/cart_view_model.dart';
import 'package:gdg_campus_coffee/market/domain/entity/catalog_product.dart';
import 'package:gdg_campus_coffee/market/presentation/mvvm/market_view_model.dart';

class MarketScreen extends StatefulWidget {
  const MarketScreen({super.key});

  @override
  State<MarketScreen> createState() => _MarketScreenState();
}

class _MarketScreenState extends State<MarketScreen> {
  late final MarketViewModel marketViewModel;
  late final CartViewModel cartViewModel;
  final TextEditingController _searchController = TextEditingController();
  final List<String> _categories = [
    'All',
    'Coffee Beans',
    'Accessories',
    'Equipment',
    'Merchandise',
  ];
  int _selectedCategoryIndex = 0;

  @override
  void initState() {
    super.initState();
    marketViewModel = MarketViewModel();
    marketViewModel.fetchCatalogProducts();
    cartViewModel = CartViewModel();
  }

  List<CatalogProduct> get _filteredProducts {
    final query = _searchController.text.toLowerCase().trim();
    final selectedCategory = _categories[_selectedCategoryIndex];

    return marketViewModel.catalogProducts.where((product) {
      final name = (product.name ?? '').toLowerCase();
      final description = (product.description ?? '').toLowerCase();
      final category = (product.category ?? '').toLowerCase();

      final matchesQuery =
          query.isEmpty || name.contains(query) || description.contains(query);

      final matchesCategory =
          selectedCategory == 'All' ||
          category.contains(selectedCategory.toLowerCase().replaceAll(' ', ''));

      return matchesQuery && matchesCategory;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ListenableBuilder(
      listenable: marketViewModel,
      builder: (context, child) {
        if (marketViewModel.loading) {
          return const Center(child: CircularProgressIndicator());
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
                      'Discover Coffee Essentials',
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
                                hintText: 'Find coffee products...',
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
                        Icons.inventory_2_outlined,
                        size: 52,
                        color: Colors.grey,
                      ),
                      SizedBox(height: 12),
                      Text(
                        'No products found.',
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
                                  Icons.inventory_2,
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
                                      product.name ?? 'Unknown Product',
                                      style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      product.description ??
                                          'Premium coffee accessory for your brewing needs',
                                      style: const TextStyle(
                                        fontSize: 14,
                                        color: Colors.grey,
                                      ),
                                    ),
                                    const SizedBox(height: 12),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          product.price != null
                                              ? '\$${product.price!.toStringAsFixed(2)}'
                                              : '\$24.99',
                                          style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w900,
                                            color: Color(0xFF4E342E),
                                          ),
                                        ),
                                        ElevatedButton(
                                          onPressed: () {
                                            final cartItem = CartItem(
                                              id: '${product.name}_${DateTime.now().millisecondsSinceEpoch}',
                                              name:
                                                  product.name ??
                                                  'Unknown Product',
                                              description:
                                                  product.description ??
                                                  'Premium coffee accessory for your brewing needs',
                                              price: product.price ?? 24.99,
                                              type: 'market',
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
