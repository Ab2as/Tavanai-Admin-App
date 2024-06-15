import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:tavanaiadminregistration/Model/RegistrationModel.dart';

class RegistrationController extends GetxController {
  var regis = <Registration>[].obs;
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  // var filteredModels = <Registration>[].obs; // New list for filtered models

  Future<void> fetchAllModels() async {
    try {
      QuerySnapshot query = await _db.collection('ClientProfile').get();
      regis.value = query.docs.map((doc) {
        Registration reg = Registration.fromFirestore(doc);
        // print('Fetched Model: ${model.name}, ${model.email}, ${model.city}');
        return reg;
      }).toList();
    } catch (e) {
      print("Error fetching data: $e");
    }
  }
}
