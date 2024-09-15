import 'package:another_carousel_pro/another_carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OfferTemplateWidget extends StatefulWidget {
  const OfferTemplateWidget({super.key});

  @override
  State<OfferTemplateWidget> createState() => _OfferTemplateWidgetState();
}

class _OfferTemplateWidgetState extends State<OfferTemplateWidget> {
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
                spreadRadius: 1
              )
            ]
        ),
        child: AnotherCarousel(
          images: [
            AssetImage("assets/images/splashImage.jpeg"),
            AssetImage("assets/images/splashImage.jpeg"),
            AssetImage("assets/images/splashImage.jpeg"),
          ],
          dotSize: 4.5,
          indicatorBgPadding: 8,
          borderRadius: true,
          dotBgColor: Colors.transparent,
          autoplay: true,
          boxFit: BoxFit.cover,

        )
    );
  }
}
