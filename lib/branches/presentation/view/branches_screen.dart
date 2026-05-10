import 'package:flutter/material.dart';
import 'package:gdg_campus_coffee/branches/presentation/mvvm/branches_view_model.dart';

class BranchesScreen extends StatefulWidget {
  const BranchesScreen({super.key});

  @override
  State<BranchesScreen> createState() => _BranchesScreenState();
}

class _BranchesScreenState extends State<BranchesScreen> {
  late final BranchesViewModel branchesViewModel;

  @override
  void initState() {
    super.initState();
    branchesViewModel = BranchesViewModel();
    branchesViewModel.fetchBranches();
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: branchesViewModel,
      builder: (context, child) {
        if (branchesViewModel.loading) {
          return const Center(child: CircularProgressIndicator());
        }
        return ListView.separated(
          padding: const EdgeInsets.all(16.0),
          itemCount: branchesViewModel.branches.length,
          separatorBuilder: (_, __) => const SizedBox(height: 14),
          itemBuilder: (context, index) {
            final branch = branchesViewModel.branches[index];
            return Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.04),
                    blurRadius: 16,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: ListTile(
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 18,
                ),
                leading: Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: Theme.of(
                      context,
                    ).colorScheme.secondary.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Icon(
                    Icons.storefront,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                title: Text(
                  branch.name ?? 'Unknown Branch',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                subtitle: Text(
                  branch.address ?? 'Visit your nearest campus coffee shop',
                  style: const TextStyle(fontSize: 14),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                trailing: const Icon(Icons.arrow_forward_ios, size: 18),
              ),
            );
          },
        );
      },
    );
  }
}
