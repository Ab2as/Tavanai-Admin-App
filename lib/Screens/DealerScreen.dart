import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tavanaiadminregistration/Controller/DealerFetch.dart';
import 'package:tavanaiadminregistration/Model/DealerModel.dart';
import 'package:tavanaiadminregistration/Screens/DealerInfo.dart';

class DealerScreen extends StatelessWidget {
  DealerScreen({super.key});
  final MyModelController _controller = Get.put(MyModelController());

  TextEditingController _searchController = TextEditingController();

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
            'Dealer Screen',
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
              child: TextField(
                controller: _searchController,
                decoration: const InputDecoration(
                  labelText: 'Search by Dealer Name',
                  labelStyle: TextStyle(
                      fontSize: 20,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
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
                if (_controller.models.isEmpty) {
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
                            MyModel model = _controller.filteredModels[index];
                            return InkWell(
                              onTap: () {
                                // _showDealerInfoDialog(context, model);
                                _navigateToNextPage(context, model.email);
                              },
                              child: Card(
                                color: const Color.fromARGB(255, 186, 184, 183),
                                elevation: 3,
                                child: ListTile(
                                  // leading: Icon(Icons.person),
                                  leading: CircleAvatar(
                                    backgroundImage: NetworkImage(model.photo),
                                  ),
                                  title: Text(
                                    model.name,
                                    style: const TextStyle(
                                        fontSize: 17,
                                        fontFamily: 'Roboto',
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black),
                                  ),
                                  subtitle: Text(
                                    model.shopAddress,
                                    style: const TextStyle(
                                        fontSize: 15,
                                        fontFamily: 'Ptserif',
                                        color: Colors.black),
                                  ),
                                  trailing: Text(
                                    model.city,
                                    style: const TextStyle(
                                        fontSize: 13,
                                        fontFamily: 'Roboto',
                                        // fontWeight: FontWeight.bold,
                                        color: Colors.black),
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

  void _navigateToNextPage(BuildContext context, String modelEmail) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => DealerInformationScreen(
              modelEmail: modelEmail)), // Pass the model name to the next page
    );
  }
}
