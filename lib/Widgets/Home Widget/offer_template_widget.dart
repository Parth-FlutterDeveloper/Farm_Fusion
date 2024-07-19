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
      height: Get.height / 4.2,
      width: Get.width,
      margin: EdgeInsets.all(16),
      child: ListView.builder(
          itemCount: 4,
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index){
            return Card(
                surfaceTintColor: Colors.white,
                child: Container(
                  width: Get.width / 1.22,
                  decoration: BoxDecoration(
                    color: Colors.black26,
                    borderRadius: BorderRadius.circular(11)
                  ),
                  // child: Center(child: Text('Offers')),
                )
            );
          }
      ),
    );
  }
}
