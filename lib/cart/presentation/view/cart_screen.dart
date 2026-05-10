import 'package:flutter/material.dart';
import 'package:gdg_campus_coffee/branches/domain/entity/branch.dart';
import 'package:gdg_campus_coffee/branches/domain/use_case/get_branches_use_case.dart';
import 'package:gdg_campus_coffee/cart/domain/entity/cart_item.dart';
import 'package:gdg_campus_coffee/cart/presentation/mvvm/cart_view_model.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  late final CartViewModel cartViewModel;
  late final GetBranchesUseCase _getBranchesUseCase;
  List<Branch> branches = [];
  bool loadingBranches = false;

  @override
  void initState() {
    super.initState();
    cartViewModel = CartViewModel();
    _getBranchesUseCase = GetBranchesUseCase();
    _loadBranches();
  }

  Future<void> _loadBranches() async {
    setState(() {
      loadingBranches = true;
    });
    branches = await _getBranchesUseCase();
    setState(() {
      loadingBranches = false;
    });
  }

  Future<void> _showBranchSelectionDialog() async {
    if (loadingBranches) {
      await _loadBranches();
    }

    if (!mounted) return;

    Branch? selectedBranch = await showDialog<Branch>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Şube Seçin'),
          content: SizedBox(
            width: double.maxFinite,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: branches.length,
              itemBuilder: (BuildContext context, int index) {
                final branch = branches[index];
                return ListTile(
                  leading: const Icon(Icons.storefront),
                  title: Text(branch.name ?? 'Unknown Branch'),
                  onTap: () {
                    Navigator.of(context).pop(branch);
                  },
                );
              },
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('İptal'),
            ),
          ],
        );
      },
    );

    if (selectedBranch != null && mounted) {
      _completeOrder(selectedBranch);
    }
  }

  void _completeOrder(Branch selectedBranch) {
    final items = cartViewModel.items;
    final totalPrice = cartViewModel.totalPrice;

    // Sipariş tamamlandıktan sonra sepeti temizle
    cartViewModel.clearCart();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          '${selectedBranch.name} şubesinden siparişiniz alındı! Toplam: \$${totalPrice.toStringAsFixed(2)}',
        ),
        duration: const Duration(seconds: 4),
        backgroundColor: Colors.green,
      ),
    );

    // Ana ekrana dön
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ListenableBuilder(
      listenable: cartViewModel,
      builder: (context, child) {
        final items = cartViewModel.items;
        final totalPrice = cartViewModel.totalPrice;

        return Scaffold(
          appBar: AppBar(
            title: const Text('Shopping Cart'),
            actions: [
              if (items.isNotEmpty)
                IconButton(
                  icon: const Icon(Icons.clear_all),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text('Clear Cart'),
                        content: const Text(
                          'Are you sure you want to clear all items?',
                        ),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.of(context).pop(),
                            child: const Text('Cancel'),
                          ),
                          TextButton(
                            onPressed: () {
                              cartViewModel.clearCart();
                              Navigator.of(context).pop();
                            },
                            child: const Text('Clear'),
                          ),
                        ],
                      ),
                    );
                  },
                ),
            ],
          ),
          body: items.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.shopping_cart_outlined,
                        size: 64,
                        color: Colors.grey,
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'Your cart is empty',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Add some coffee to get started!',
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                )
              : Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        padding: const EdgeInsets.all(16.0),
                        itemCount: items.length,
                        itemBuilder: (context, index) {
                          final item = items[index];
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 12.0),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(16),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.05),
                                    blurRadius: 12,
                                    offset: const Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: 60,
                                      height: 60,
                                      decoration: BoxDecoration(
                                        color: theme.colorScheme.secondary
                                            .withOpacity(0.2),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Icon(
                                        item.type == 'menu'
                                            ? Icons.local_cafe
                                            : Icons.inventory_2,
                                        color: theme.colorScheme.primary,
                                        size: 28,
                                      ),
                                    ),
                                    const SizedBox(width: 16),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            item.name,
                                            style: const TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          if (item.description != null) ...[
                                            const SizedBox(height: 4),
                                            Text(
                                              item.description!,
                                              style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.grey.shade600,
                                              ),
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ],
                                          const SizedBox(height: 8),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                '\$${item.price?.toStringAsFixed(2) ?? '0.00'}',
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w900,
                                                  color:
                                                      theme.colorScheme.primary,
                                                ),
                                              ),
                                              Row(
                                                children: [
                                                  IconButton(
                                                    icon: const Icon(
                                                      Icons.remove,
                                                    ),
                                                    onPressed: item.quantity > 1
                                                        ? () => cartViewModel
                                                              .updateQuantity(
                                                                item.id,
                                                                item.quantity -
                                                                    1,
                                                              )
                                                        : null,
                                                  ),
                                                  Text(
                                                    '${item.quantity}',
                                                    style: const TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                  IconButton(
                                                    icon: const Icon(Icons.add),
                                                    onPressed: () =>
                                                        cartViewModel
                                                            .updateQuantity(
                                                              item.id,
                                                              item.quantity + 1,
                                                            ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    IconButton(
                                      icon: const Icon(Icons.delete_outline),
                                      onPressed: () =>
                                          cartViewModel.removeItem(item.id),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(20.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 20,
                            offset: const Offset(0, -4),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Total:',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                '\$${totalPrice.toStringAsFixed(2)}',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: theme.colorScheme.primary,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: cartViewModel.items.isNotEmpty
                                  ? _showBranchSelectionDialog
                                  : null,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: theme.colorScheme.primary,
                                padding: const EdgeInsets.symmetric(
                                  vertical: 16,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              child: const Text(
                                'Proceed to Checkout',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
        );
      },
    );
  }
}
