import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:tavanaiadminregistration/Model/DealerModel.dart';

class MyModelController extends GetxController {
  var models = <MyModel>[].obs;
  var filteredModels = <MyModel>[].obs; // New list for filtered models
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> fetchAllModels() async {
    try {
      QuerySnapshot query = await _db.collection('DealerProfile').get();
      models.value = query.docs.map((doc) {
        MyModel model = MyModel.fromFirestore(doc);
        return model;
      }).toList();
      // Initially set filteredModels to be the same as models
      filteredModels.value = List.from(models);
    } catch (e) {
      print("Error fetching data: $e");
    }
  }

  // Method to filter models based on search query
  void filterModels(String query) {
    filteredModels.value = models.where((model) {
      // Case-insensitive search by dealer name
      return model.name.toLowerCase().contains(query.toLowerCase());
    }).toList();
  }
}
