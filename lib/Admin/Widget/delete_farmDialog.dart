import 'package:farm_booking_app/Common%20Widget/button_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DeleteFarmDialog {

  bool loading = false;

  void showDeleteDialog(BuildContext context,VoidCallback onTap) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Delete',style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 30,
              fontFamily: "LocalFont",
              color: Colors.green.shade900,
              letterSpacing: 1
          ),),
          content: Text('Are you sure you want to Delete a farm?',style: TextStyle(
              fontFamily: "LocalFont",
              fontSize: 18,
              fontWeight: FontWeight.bold,
              wordSpacing: 1
          ),),
          actions: <Widget>[
            ButtonWidget(
                text: "Delete",
                width: 5,
                loading: loading,
                txtColor: Colors.red,
                backColor: Colors.transparent,
                onTap: onTap
            ),
            SizedBox(height: 15),
            ButtonWidget(
              text: "Cancel",
              width: 5,
              loading: loading,
              txtColor: Colors.black54,
              backColor: Colors.transparent,
              onTap: () {
                Get.back();
              },
            ),
          ],
        );
      },
    );
  }
}