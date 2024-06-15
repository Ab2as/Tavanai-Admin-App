import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:tavanaiadminregistration/Model/UpdateClaim.dart' as mode;

class AuthController extends GetxController {
  Future<bool> UpdateClaimRegister(
    String documentId,
    String serial,
    String battery,
    String model,
    String dealerName,
    String clientName,
    String regisDate,
    String claimDate,
    String shopAddress,
    String clientAddress,
    String completed,
  ) async {
    try {
      if (serial.isNotEmpty &&
          battery.isNotEmpty &&
          model.isNotEmpty &&
          dealerName.isNotEmpty &&
          clientName.isNotEmpty &&
          regisDate.isNotEmpty &&
          claimDate.isNotEmpty &&
          shopAddress.isNotEmpty &&
          clientAddress.isNotEmpty &&
          completed.isNotEmpty) {
        //save user to our auth and firebase firestore

        mode.UpdateClaim claim = mode.UpdateClaim(
          serial: serial,
          battery: battery,
          model: model,
          dealerName: dealerName,
          clientName: clientName,
          regisDate: regisDate,
          claimDate: claimDate,
          shopAddress: shopAddress,
          clientAddress: clientAddress,
          completed: completed,
        );

        await FirebaseFirestore.instance
            .collection('ClaimRegister')
            .doc(documentId)
            .set(claim.toJson());
        return true;
      } else {
        Get.snackbar(
          "Error Creating Account",
          'Please enter all the fields',
        );
        return false;
      }
    } catch (e) {
      Get.snackbar(
        "Error Creating Account",
        e.toString(),
      );
      return false;
    }
  }
}
