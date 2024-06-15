import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tavanaiadminregistration/Controller/RegistrationController.dart';
import 'package:tavanaiadminregistration/Model/RegistrationModel.dart';

class InverterScreen extends StatelessWidget {
  InverterScreen({required this.dealerEmail, super.key});
  String dealerEmail;
  final RegistrationController _controller = Get.put(RegistrationController());

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
              )),
          title: const Text(
            'Inverter Battery',
            style: TextStyle(
                fontSize: 30,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.bold,
                color: Colors.black),
          ),
          centerTitle: true,
          backgroundColor: const Color.fromARGB(255, 221, 216, 216),
          elevation: 0.0,
        ),
        body: Column(
          children: [
            const SizedBox(
              height: 30,
            ),
            Obx(
              () {
                if (_controller.regis.isEmpty) {
                  return const Center(child: CircularProgressIndicator());
                } else {
                  Registration? reg = _controller.regis.firstWhereOrNull(
                    (reg) =>
                        reg.dealerEmail == dealerEmail &&
                        reg.battery == 'Inverter Battery',
                  );

                  // Check if the model was found
                  if (reg == null) {
                    return const Center(
                        child:
                            Text('No data available for the current Battery'));
                  }

                  return Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 10),
                      height: MediaQuery.of(context)
                          .size
                          .height, // Adjust the height as needed
                      child: ListView.builder(
                        itemCount: _controller.regis
                            .where((reg) =>
                                reg.dealerEmail == dealerEmail &&
                                reg.battery == 'Inverter Battery')
                            .length, // Assuming only one data for now
                        itemBuilder: (context, index) {
                          return CustomListTile(
                            dealerName: reg.name,
                            batteryType: reg.email,
                            onTap: () {
                              // Show dialog with Firebase data
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: const Text(
                                      'Client Data',
                                      style: TextStyle(
                                          fontFamily: 'Roboto',
                                          fontSize: 30,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    content: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Client Name: ${reg.name}',
                                          style: const TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          'Battery Serial: ${reg.serial}',
                                          style: const TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          'Battery Type: ${reg.battery}',
                                          style: const TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          'Battery Model: ${reg.model}',
                                          style: const TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          'Purchase Date: ${reg.date}',
                                          style: const TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          'Client Address: ${reg.address}',
                                          style: const TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          'Pincode: ${reg.pincode}',
                                          style: const TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          'Client Email: ${reg.email}',
                                          style: const TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        // Add more fields as needed
                                      ],
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: const Text(
                                          'Close',
                                          style: TextStyle(
                                              fontFamily: 'Roboto',
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                          );
                        },
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
}

class CustomListTile extends StatelessWidget {
  final String dealerName;
  final String batteryType;
  final VoidCallback onTap;

  const CustomListTile({
    required this.dealerName,
    required this.batteryType,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Card(
        elevation: 3,
        child: ListTile(
          leading: const Icon(Icons.battery_alert),
          title: Text(
            dealerName,
            style: const TextStyle(
              fontSize: 17,
              fontFamily: 'Roboto',
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          subtitle: Text(batteryType),
        ),
      ),
    );
  }
}
