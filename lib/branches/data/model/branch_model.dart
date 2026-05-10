import 'package:gdg_campus_coffee/branches/domain/entity/branch.dart';

class BranchModel {
  final String? name;
  final String? address;

  BranchModel({this.name, this.address});

  Branch toEntity() {
    return Branch(name: name, address: address);
  }

  // Firestore'dan veri okumak için
  factory BranchModel.fromFirestore(Map<String, dynamic> data) {
    return BranchModel(
      name: data['name'] as String?,
      address: data['address'] as String?,
    );
  }

  // Firestore'a göndermek için
  Map<String, dynamic> toFirestore() {
    return {"name": name, "address": address};
  }
}
