import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tavanaiadminregistration/Screens/AutomotiveBattery.dart';
import 'package:tavanaiadminregistration/Screens/ERickshawBattery.dart';
import 'package:tavanaiadminregistration/Screens/InverterBattery.dart';
import 'package:tavanaiadminregistration/Widget/Card3D.dart';

class DealerInformationScreen extends StatelessWidget {
  DealerInformationScreen({required this.modelEmail, super.key});

  String modelEmail;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
            'Dealer Information',
            style: TextStyle(
                fontSize: 30,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.bold,
                color: Colors.black),
          ),
          centerTitle: true,
          backgroundColor: Colors.grey,
          elevation: 0.0,
        ),
        body: Container(
          height: double.infinity,
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  colors: [Colors.grey, Colors.white],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    height: 260,
                    width: 190,
                    child: ThreeDCard(
                        imageUrl:
                            'https://media.istockphoto.com/id/1202474729/vector/car-battery-icon.jpg?s=612x612&w=0&k=20&c=SjsQuB9s-c8ZnnLt1_JHwXkNnzQsoeIF3w12Nc5qjH8=',
                        text: "Automotive Battery",
                        onPressed: () {
                          Get.to(
                              () => AutomotiveScreen(dealerEmail: modelEmail));
                        }),
                  ),
                  SizedBox(
                    height: 260,
                    width: 190,
                    child: ThreeDCard(
                        imageUrl:
                            'https://as1.ftcdn.net/v2/jpg/05/75/35/08/1000_F_575350809_SEzLhS61MGfufRWq0PeaFRG4l0NmIhcQ.jpg',
                        text: "Inverter Battery",
                        onPressed: () {
                          Get.to(() => InverterScreen(dealerEmail: modelEmail));
                        }),
                  ),
                ],
              ),
              Center(
                child: SizedBox(
                  height: 260,
                  width: 190,
                  child: ThreeDCard(
                      imageUrl:
                          'https://www.shutterstock.com/shutterstock/photos/1719435361/display_1500/stock-vector-illustration-of-hybrid-battery-rickshaw-with-passenger-1719435361.jpg',
                      text: "E-Rickshaw Battery",
                      onPressed: () {
                        Get.to(ERickshawScreen(dealerEmail: modelEmail));
                      }),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
