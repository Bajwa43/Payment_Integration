import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jazzcash_flutter/jazzcash_flutter.dart';
import 'package:payment_integration_gateway/Jazz_cash_Payment_gateway_integration/jazz_cash_product.dart';

class JazzCashHolder {
  
  String integritySalt = "z30wu8c1ew";
  String merchantID = "MC59242";
  String merchantPassword = "vy0c59sve9";
  String transactionUrl = "www.kb.com";
  DateTime date = DateTime.now();

  makePaymentViaJazzCash(BuildContext context, JazzCashProduct product) async {
    //
    try {
      //
      JazzCashFlutter jazzCashFlutter = JazzCashFlutter(
          merchantId: merchantID,
          merchantPassword: merchantPassword,
          integritySalt: integritySalt,
          isSandbox: true);

      //
      JazzCashPaymentDataModelV1 cashPaymentDataModelV1 = JazzCashPaymentDataModelV1(
          ppAmount: product.price,
          ppBillReference:
              'ref${date.year}${date.month}${date.day}${date.hour}${date.millisecond}',
          ppDescription:
              'My First Payment on: ${product.name} with ${product.price} price.',
          ppMerchantID: merchantID,
          ppPassword: merchantPassword,
          ppReturnURL: transactionUrl);

      //
      var response = await jazzCashFlutter.startPayment(
          paymentDataModelV1: cashPaymentDataModelV1, context: context);

      //
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Response: $response')));

      //
    } catch (e) {
       throw Exception(e);
    }
  }

  // ....
}
