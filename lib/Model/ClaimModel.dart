import 'package:cloud_firestore/cloud_firestore.dart';

class Claim {
  final String serial;
  final String battery;
  final String model;
  final String regisDate;
  final String claimDate;
  final String dealerName;
  final String clientName;
  final String shopAddress;
  final String clientAddress;
  String completed;

  Claim({
    required this.serial,
    required this.battery,
    required this.model,
    required this.dealerName,
    required this.clientName,
    required this.regisDate,
    required this.claimDate,
    required this.shopAddress,
    required this.clientAddress,
    required this.completed,
  });

  factory Claim.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return Claim(
      serial: data['serial'] ?? '',
      battery: data['battery'] ?? '', // Assuming city is an integer
      model: data['model'] ?? '',
      dealerName: data['dealerName'] ?? '',
      clientName: data['clientName'] ?? '',
      regisDate: data['regisDate'] ?? '',
      claimDate: data['claimDate'] ?? '',
      shopAddress: data['shopAddress'] ?? '',
      clientAddress: data['clientAddress'] ?? '',
      completed: data['completed'] ?? 'false',
    );
  }
}
