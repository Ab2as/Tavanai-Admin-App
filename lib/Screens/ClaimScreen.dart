import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tavanaiadminregistration/Controller/AuthController.dart';
import 'package:tavanaiadminregistration/Controller/ClaimFetch.dart';
import 'package:tavanaiadminregistration/Model/ClaimModel.dart';

class ClaimScreen extends StatefulWidget {
  ClaimScreen({super.key});

  @override
  State<ClaimScreen> createState() => _ClaimScreenState();
}

class _ClaimScreenState extends State<ClaimScreen> {
  final MyModelController1 _controller = Get.put(MyModelController1());
  AuthController auth = Get.put(AuthController());

  Future<String?> getDocumentIdBySerial(String serial) async {
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('ClaimRegister')
        .where('serial', isEqualTo: serial)
        .get();
    if (snapshot.docs.isNotEmpty) {
      return snapshot.docs.first.id;
    }
    return null;
  }

  TextEditingController _searchController = TextEditingController();
  SharedPreferences? _prefs;

  @override
  Widget build(BuildContext context) {
    _controller.fetchAllModels();

    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 220, 215, 215),
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(
              Icons.arrow_back,
              size: 30,
              color: Colors.black,
            ),
          ),
          title: const Text(
            'Claim Screen',
            style: TextStyle(
              fontSize: 30,
              fontFamily: 'Roboto',
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          centerTitle: true,
          backgroundColor: const Color.fromARGB(255, 221, 216, 216),
          elevation: 0.0,
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
              child: TextField(
                controller: _searchController,
                decoration: const InputDecoration(
                  labelText: 'Search by Serial No.',
                  labelStyle: TextStyle(
                    fontSize: 20,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                  prefixIcon: Icon(
                    Icons.search,
                    color: Colors.black,
                    size: 30,
                  ),
                ),
                onChanged: (value) {
                  _controller.filterModels(value);
                },
              ),
            ),
            Obx(
              () {
                if (_controller.claims.isEmpty) {
                  return const Center(child: CircularProgressIndicator());
                } else {
                  return Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        onTap: () {
                          FocusScope.of(context).unfocus();
                        },
                        child: ListView.builder(
                          itemCount: _controller.filteredModels.length,
                          itemBuilder: (context, index) {
                            Claim claim = _controller.filteredModels[index];
                            return InkWell(
                              onTap: () {
                                _showClaimDetailsDialog(context, claim);
                              },
                              child: Card(
                                color: claim.completed == 'true'
                                    ? const Color.fromARGB(255, 123, 172, 124)
                                    : const Color.fromARGB(255, 215, 154, 150),
                                elevation: 3,
                                child: ListTile(
                                  leading: const Icon(Icons.person_2_rounded),
                                  title: Text(
                                    claim.serial,
                                    style: const TextStyle(
                                      fontSize: 17,
                                      fontFamily: 'Roboto',
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                  subtitle: Text(
                                    claim.shopAddress,
                                    style: const TextStyle(
                                      fontSize: 15,
                                      fontFamily: 'Ptserif',
                                      color: Colors.black,
                                    ),
                                  ),
                                  trailing: claim.completed == 'true'
                                      ? const Icon(
                                          Icons.done_all_rounded,
                                          color: Colors.greenAccent,
                                        )
                                      : const Icon(
                                          Icons.pending_actions_rounded,
                                          color: Colors.redAccent,
                                        ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showClaimDetailsDialog(BuildContext context, Claim claim) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            'Claim Details',
            style: TextStyle(
                fontFamily: 'Roboto',
                fontSize: 30,
                fontWeight: FontWeight.bold),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Serial Number: ${claim.serial}',
                style:
                    const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
              Text(
                'Battery: ${claim.battery}',
                style:
                    const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
              Text(
                'Model: ${claim.model}',
                style:
                    const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
              Text(
                'Registration Date : ${claim.regisDate}',
                style:
                    const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
              Text(
                'Claim Date: ${claim.claimDate}',
                style:
                    const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
              Text(
                'Client Name: ${claim.clientName}',
                style:
                    const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
              Text(
                'Dealer Name: ${claim.dealerName}',
                style:
                    const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
              Text(
                'Client Address: ${claim.clientAddress}',
                style:
                    const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
              Text(
                'Dealer Shop Address: ${claim.shopAddress}',
                style:
                    const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () async {
                    String? documentId =
                        await getDocumentIdBySerial(claim.serial);
                    if (documentId != null) {
                      bool isUpdated = await auth.UpdateClaimRegister(
                          documentId,
                          claim.serial,
                          claim.battery,
                          claim.model,
                          claim.dealerName,
                          claim.clientName,
                          claim.regisDate,
                          claim.claimDate,
                          claim.shopAddress,
                          claim.clientAddress,
                          'true');
                      if (isUpdated) {
                        claim.completed = 'true';
                        setState(() {});
                        Navigator.of(context).pop();
                      }
                    }
                  },
                  child: const Text(
                    'Completed',
                    style: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                TextButton(
                  onPressed: () async {
                    String? documentId =
                        await getDocumentIdBySerial(claim.serial);
                    if (documentId != null) {
                      bool isUpdated = await auth.UpdateClaimRegister(
                          documentId,
                          claim.serial,
                          claim.battery,
                          claim.model,
                          claim.dealerName,
                          claim.clientName,
                          claim.regisDate,
                          claim.claimDate,
                          claim.shopAddress,
                          claim.clientAddress,
                          'false');
                      if (isUpdated) {
                        claim.completed = 'false';
                        // Trigger UI update
                        setState(() {});
                        Navigator.of(context).pop();
                      }
                    }
                  },
                  child: const Text(
                    'Pending',
                    style: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
