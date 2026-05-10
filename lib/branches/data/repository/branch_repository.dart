import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gdg_campus_coffee/branches/data/model/branch_model.dart';
import 'package:gdg_campus_coffee/branches/domain/entity/branch.dart';
import 'package:gdg_campus_coffee/branches/domain/repository/i_branch_repository.dart';

class BranchRepository implements IBranchRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Future<List<Branch>> getBranches() async {
    try {
      final snapshot = await _firestore.collection('branches').get();
      if (snapshot.docs.isEmpty) {
        print("Firestore collection 'branches' returned no documents.");
      }

      final models = snapshot.docs.map((doc) {
        final data = doc.data();
        if (data is Map<String, dynamic>) {
          return BranchModel.fromFirestore(data);
        }
        print("Firestore document '${doc.id}' returned unexpected data: $data");
        return BranchModel();
      }).toList();

      return models.map((model) => model.toEntity()).toList();
    } catch (e, st) {
      print("Firestore'dan şubeler çekilirken hata oluştu: $e\n$st");
      rethrow;
    }
  }
}
