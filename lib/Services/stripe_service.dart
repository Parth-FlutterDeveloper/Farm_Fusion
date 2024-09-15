import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as http;

class StripeService {
  static String apiBase = 'https://api.stripe.com/v1';
  static String paymentApiUrl = '${StripeService.apiBase}/payment_intents';
  static String secretKey = "sk_test_51PywedFI98VnILGAULS5RaStMp3t7FccEtj8iRBKeRLDwL9NBcPEaEDIbxeUomQby4qoWlIlI27lLOSw1qzJk5T900r8dHGTFD";
  static Map<String, String> headers = {
    "Authorization": "Bearer ${StripeService.secretKey}",
    "Content-Type": "application/x-www-form-urlencoded"
  };

  static init() {
    Stripe.publishableKey = "pk_test_51PywedFI98VnILGAfU5MweE63fOtina79LPjZ4MEMoEnXLvOfAm1FVuYEM1QUmVL3m6ROWgjFudmH6p1ZDL8emMT00liDo4fpn";
  }

  static Future<Map<String, dynamic>> createPaymentIntent(String amount, String currency) async {
    try{
      Map<String, dynamic> body = {
        'amount': amount,
        'currency': currency,
        'payment_method_types[]': 'card'
      };

      var response = await http.post(
        Uri.parse(StripeService.paymentApiUrl),
        body: body,
        headers: StripeService.headers
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception("Failed to create Payment Intent");
      }
    }
    catch(e){
      throw Exception("Failed to create Payment Intent");
    }
  }

  static Future<void> initPaymentSheet(String amount, String currency) async {
    try{
      final paymentIntent = await createPaymentIntent(amount, currency);
      await Stripe.instance.initPaymentSheet(
          paymentSheetParameters: SetupPaymentSheetParameters(
            paymentIntentClientSecret: paymentIntent['client_secret'],
            merchantDisplayName: "Dummy",
            style: ThemeMode.system
          )
      );
    }
    catch(e){
      throw Exception("Failed to init Payment Sheet");
    }
  }

  static Future<void> presentPaymentSheet() async {
    try{
      await Stripe.instance.presentPaymentSheet();
    }
    catch(e) {
      throw Exception("Failed to present Payment Sheet");
    }
  }

}