import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:phonepe_payment_sdk/phonepe_payment_sdk.dart';

class PhonePePayment extends StatefulWidget {
  const PhonePePayment({super.key});

  @override
  State<PhonePePayment> createState() => _PhonePePaymentState();
}

class _PhonePePaymentState extends State<PhonePePayment> {

  // Variables For PhonePe
  String environment = "UAT_SIM";
  String appId = "";
  String merchantId = "PGTESTPAYUAT";
  bool enableLogging = true;
  String checksum = "";
  String saltKey = "099eb0cd-02cf-4e2a-8aca-3e6c6aff0399";
  String saltIndex = "1";
  String apiEndPoint = "/pg/v1/pay";

  String callbackUrl = "https://webhook.site/82a480d3-b967-45d9-b685-bc58202afd0a"; // To check Payment Done or Note
  String body = "";
  Object? result;


  void phonePeInit() {

    PhonePePaymentSdk.init(environment, appId, merchantId, enableLogging)
        .then((val) => {
      setState(() {
        print("VVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVV $val");
        result = 'PhonePe SDK Initialized - $val';
      })
    })
    .catchError((error) {
      handleError(error);
      return <dynamic>{};
    });

  }


  getCheckSum() {

    final requestData = {
      "merchantId": merchantId,
      "merchantTransactionId": "transaction_123",
      "merchantUserId": "90223250",
      "amount": 1000,
      "mobileNumber": "9999999999",
      "callbackUrl": callbackUrl,
      "paymentInstrument": {
        "type": "PAY_PAGE",
      },
    };

    String base64Body = base64.encode(utf8.encode(json.encode(requestData)));
    checksum = "${sha256.convert(utf8.encode(base64Body+apiEndPoint+saltKey)).toString()}###$saltIndex";
    print("cccccccccccccccccccccccccc $base64Body");
    print("cccccccccccccccccccccccccc $checksum");

    return base64Body;

  }


  void startPgTransaction() async {
    try {
      print("body : $body");
      print("url : $callbackUrl");
      print("checksum : $checksum");
      print("end : $apiEndPoint");
      var response = await PhonePePaymentSdk.startTransaction(body, callbackUrl, checksum, apiEndPoint);
      if (response != null) {
        String status = response['status'].toString();
        String error = response['error'].toString();
        setState(() {
          print("RRRRRRRRRRRRRRRRRRRRRRRRR $response");
          result = (status == 'SUCCESS')
              ? "Flow Complete - status: SUCCESS"
              : "Flow Complete - status: $status, error: $error";
        });
      } else {
        setState(() {
          result = "Transaction Flow Incomplete";
        });
      }
    } catch (error) {
      handleError(error);
    }
  }


  void handleError(error) {

    setState(() {
      result = {"error" : error};
    });

  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    phonePeInit(); // Calling Function
    body = getCheckSum().toString();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.green.shade300,
        title: Text("Pay now",style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            fontFamily: "LocalFont",
            color: Colors.black,
            letterSpacing: 1.5
        ),),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton(
              child: Text("Pay now"),
              onPressed: () {
                  startPgTransaction();
              },
            ),
            SizedBox(height: 20),
            Text("Result : $result"),
          ],
        ),
      ),
    );
  }

}