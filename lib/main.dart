import 'package:flutter/material.dart';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:payment_integration_gateway/Jazz_cash_Payment_gateway_integration/jazz_cash_holder.dart';
import 'package:payment_integration_gateway/Jazz_cash_Payment_gateway_integration/jazz_cash_product.dart';
import 'package:payment_integration_gateway/Stripe_payment_integration_gatway/stripe_provider.dart';

void main() async {
  
  WidgetsFlutterBinding.ensureInitialized();

  
  Stripe.publishableKey =
      'pk_test_51Nlec9GSAMsWwnVZBeTNjVksoGihdCE990qLDJl4g1Tdsn3a4ptm6u5zN656Rq6agubuYrAJ8Z1NsFZART2pQyvv00XVvMkMt9';

  
  await dotenv.load(fileName: 'assets/.env');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  StripeHolder stripeHolder = StripeHolder();
  JazzCashHolder jazzCashHolder = JazzCashHolder();
  JazzCashProduct product = JazzCashProduct(name: 'ALi', price: '1000');

  void stripeCall() {
    stripeHolder.makePayment(context);
  }

  void jazzCashCall() {
    
    try {
      jazzCashHolder.makePaymentViaJazzCash(context, product);
    } catch (e) {
      
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Payment canceled!\n$e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            
            ElevatedButton(
                onPressed: stripeCall,
                style: const ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(Colors.amber)),
                child: const Text('Payment by Stripe Gatway ')),
            
            ElevatedButton(
                onPressed: jazzCashCall,
                style: const ButtonStyle(
                    backgroundColor:
                        MaterialStatePropertyAll(Colors.cyanAccent)),
                child: const Text('Payment by Jazz Cash  '))
          ],
        ),
      ),
    );
  }
}
