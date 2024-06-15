import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:tavanaiadminregistration/Model/ClaimModel.dart';

class MyModelController1 extends GetxController {
  var claims = <Claim>[].obs;
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  var filteredModels = <Claim>[].obs; // New list for filtered models

  Future<void> fetchAllModels() async {
    try {
      QuerySnapshot query = await _db.collection('ClaimRegister').get();
      claims.value = query.docs.map((doc) {
        Claim claim = Claim.fromFirestore(doc);
        return claim;
      }).toList();
      filteredModels.value = List.from(claims);
    } catch (e) {
      print("Error fetching data: $e");
    }
  }

  void filterModels(String query) {
    filteredModels.value = claims.where((claim) {
      // Case-insensitive search by dealer name
      return claim.serial.toLowerCase().contains(query.toLowerCase());
    }).toList();
  }
}
