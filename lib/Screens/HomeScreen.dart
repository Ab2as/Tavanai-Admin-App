import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tavanaiadminregistration/Screens/ClaimScreen.dart';
import 'package:tavanaiadminregistration/Screens/DealerScreen.dart';
import 'package:tavanaiadminregistration/Widget/Card3D.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Tavanai',
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 30,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          elevation: 0.0,
          backgroundColor: Colors.grey,
        ),
        body: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  colors: [Colors.grey, Colors.white],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 30,
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Welcome ",
                    style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'PlayFair'),
                  ),
                  Text(
                    'Mohd Abbas',
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'PlayFair'),
                  ),
                ],
              ),
              const SizedBox(
                height: 40,
              ),
              SizedBox(
                height: 240,
                width: 190,
                child: ThreeDCard(
                    imageUrl:
                        'https://media.istockphoto.com/id/1202474729/vector/car-battery-icon.jpg?s=612x612&w=0&k=20&c=SjsQuB9s-c8ZnnLt1_JHwXkNnzQsoeIF3w12Nc5qjH8=',
                    text: "Claim",
                    onPressed: () {
                      Get.to(() => ClaimScreen());
                    }),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 240,
                width: 190,
                child: ThreeDCard(
                    imageUrl:
                        'https://thumbs.dreamstime.com/b/flat-design-ready-to-animation-characters-ready-to-animation-web-page-template-online-registration-form-office-work-131331696.jpg',
                    text: "Dealer",
                    onPressed: () {
                      Get.to(() => DealerScreen());
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
