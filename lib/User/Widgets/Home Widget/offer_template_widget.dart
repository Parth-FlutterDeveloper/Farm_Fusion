import 'package:another_carousel_pro/another_carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class OfferController extends GetxController {

  RxList<String> images = [
    "assets/images/splashImage.jpeg",
    "assets/images/splashImage.jpeg",
    "assets/images/splashImage.jpeg",
  ].obs;

}

class OfferTemplateWidget extends StatefulWidget {
  const OfferTemplateWidget({super.key});

  @override
  State<OfferTemplateWidget> createState() => _OfferTemplateWidgetState();
}

class _OfferTemplateWidgetState extends State<OfferTemplateWidget> {

  final OfferController offerController = Get.put(OfferController());

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(20),
      height: Get.height / 4.2,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(11),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 3,
            spreadRadius: 1,
          )
        ],
      ),
      // Using Obx to listen for changes in the controller
      child: Obx(() {
        return AnotherCarousel(
          images: offerController.images
              .map((imagePath) => AssetImage(imagePath))
              .toList(),
          dotSize: 4.5,
          indicatorBgPadding: 8,
          borderRadius: true,
          dotBgColor: Colors.transparent,
          autoplay: true,
          boxFit: BoxFit.cover,
        );
      }),
    );
  }
}
