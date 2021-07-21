import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:eventz/backend/mock_data.dart';
import 'package:eventz/backend/models.dart';
import 'package:eventz/global_values.dart';
import 'package:eventz/utils/global_widgets.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:stripe_payment/stripe_payment.dart';
import 'package:http/http.dart' as http;

class StorePage extends StatefulWidget {
  const StorePage({
    Key key,
  }) : super(key: key);

  @override
  _StorePageState createState() => _StorePageState();
}

class _StorePageState extends State<StorePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 100,
          // backgroundColor: Colors.transparent,
          elevation: 0.0,
          title: Column(
            children: [
              Image.asset(
                GlobalValues.logoImageBlue,
                height: 60,
                width: 60,
              ),
              SubtitleText(
                'Store',
                // fontStyle: FontStyle.italic,
                fontWeight: FontWeight.bold,
              )
            ],
          ),
          actions: [
            IconButton(
              onPressed: () {},
              icon: FaIcon(FontAwesomeIcons.shoppingCart),
            ),
          ],
        ),
        body: Stack(
          children: [
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 300,
                color: Theme.of(context).cardColor,
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height,
              child: CarouselSlider(
                  items: List.generate(shopItems.length, (index) {
                    StoreItem item = StoreItem.fromMap(shopItems[index]);
                    return StoreItemView(storeItem: item);
                  }),
                  options: CarouselOptions(
                    height: MediaQuery.of(context).size.height * 0.8,
                    aspectRatio: 16 / 9,
                    viewportFraction: 0.7,
                    initialPage: 0,
                    enableInfiniteScroll: true,
                    reverse: false,
                    autoPlay: true,
                    autoPlayInterval: Duration(seconds: 3),
                    autoPlayAnimationDuration: Duration(milliseconds: 800),
                    autoPlayCurve: Curves.fastOutSlowIn,
                    enlargeCenterPage: true,
                    scrollDirection: Axis.horizontal,
                  )),
            ),
          ],
        ));
  }
}

class StoreItemView extends StatefulWidget {
  final StoreItem storeItem;
  const StoreItemView({Key key, @required this.storeItem}) : super(key: key);

  @override
  _StoreItemViewState createState() => _StoreItemViewState();
}

class _StoreItemViewState extends State<StoreItemView> {
  int amount;
  String url =
      'https://us-central1-demostripe-b9557.cloudfunctions.net/StripePI';
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Align(
          alignment: Alignment.topCenter,
          child: Image.asset(
            widget.storeItem.imageURL,
            height: 350,
            width: 400,
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: SizedBox(
            height: 360,
            child: Stack(
              children: [
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10.0)
                      .add(EdgeInsets.only(bottom: 80.0)),
                  decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      borderRadius: BorderRadius.circular(15.0),
                      boxShadow: [
                        BoxShadow(
                            blurRadius: 15,
                            spreadRadius: 1,
                            color: Colors.black.withOpacity(0.2))
                      ]),
                  padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Center(
                          child: TitleText(
                        widget.storeItem.title,
                        textAlign: TextAlign.center,
                        fontSize: 24,
                        overflow: TextOverflow.clip,
                        color: Theme.of(context).primaryColor,
                      )),
                      SubtitleText(
                        widget.storeItem.description,
                        textAlign: TextAlign.center,
                      ),
                      Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SubtitleText(
                            '\$${widget.storeItem.price}',
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ))
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                      padding: const EdgeInsets.only(bottom: 65.0),
                      child: FloatingActionButton.extended(
                        heroTag: widget.storeItem.id,
                        backgroundColor: Theme.of(context).primaryColor,
                        onPressed: () async {},
                        label: TitleText(
                          'Add to basket',
                          fontSize: 16,
                          color: Theme.of(context).textTheme.bodyText1.color,
                        ),
                      )),
                )
              ],
            ),
          ),
        )
      ],
    );
  }

  Future<void> createPaymentMethod() async {
    StripePayment.setStripeAccount(null);
    amount = (widget.storeItem.price * 100).toInt();
    print('amount in pence/cent which will be charged = $amount');
    //step 1: add card
    PaymentMethod paymentMethod = PaymentMethod();
    paymentMethod = await StripePayment.paymentRequestWithCardForm(
      CardFormPaymentRequest(),
    ).then((PaymentMethod paymentMethod) {
      return paymentMethod;
    }).catchError((e) {
      print('Errore Card: ${e.toString()}');
    });
    paymentMethod != null
        ? processPaymentAsDirectCharge(paymentMethod)
        : showDialog(
            context: context,
            builder: (BuildContext context) => AlertDialog(
                  title: TitleText('Error'),
                  content: SubtitleText(
                      'It is not possible to pay with this card. Please try again with a different card'),
                ));
  }

  Future<void> processPaymentAsDirectCharge(PaymentMethod paymentMethod) async {
    //step 2: request to create PaymentIntent, attempt to confirm the payment & return PaymentIntent
    final http.Response response = await http.post(
        Uri.parse('$url?amount=$amount&currency=GBP&paym=${paymentMethod.id}'));
    print('Now i decode');
    if (response.body != null && response.body != 'error') {
      final paymentIntentX = jsonDecode(response.body);
      final status = paymentIntentX['paymentIntent']['status'];
      final strAccount = paymentIntentX['stripeAccount'];
      //step 3: check if payment was succesfully confirmed
      if (status == 'succeeded') {
        //payment was confirmed by the server without need for futher authentification
        StripePayment.completeNativePayRequest();
        // setState(() {
        //   text =
        //       'Payment completed. ${paymentIntentX['paymentIntent']['amount'].toString()}p succesfully charged';
        // });
      } else {
        //step 4: there is a need to authenticate
        StripePayment.setStripeAccount(strAccount);
        await StripePayment.confirmPaymentIntent(PaymentIntent(
                paymentMethodId: paymentIntentX['paymentIntent']
                    ['payment_method'],
                clientSecret: paymentIntentX['paymentIntent']['client_secret']))
            .then(
          (PaymentIntentResult paymentIntentResult) async {
            //This code will be executed if the authentication is successful
            //step 5: request the server to confirm the payment with
            final statusFinal = paymentIntentResult.status;
            if (statusFinal == 'succeeded') {
              StripePayment.completeNativePayRequest();
            } else if (statusFinal == 'processing') {
              StripePayment.cancelNativePayRequest();

              showDialog(
                  context: context,
                  builder: (BuildContext context) => AlertDialog(
                        title: TitleText('Warning'),
                        content: SubtitleText(
                            'The payment is still in \'processing\' state. This is unusual. Please contact us'),
                      ));
            } else {
              StripePayment.cancelNativePayRequest();

              showDialog(
                  context: context,
                  builder: (BuildContext context) => AlertDialog(
                        title: TitleText('Error'),
                        content: SubtitleText(
                            'There was an error in creating the payment. Please try again with another card'),
                      ));
            }
          },
          //If Authentication fails, a PlatformException will be raised which can be handled here
        ).catchError((e) {
          //case B1
          StripePayment.cancelNativePayRequest();

          showDialog(
              context: context,
              builder: (BuildContext context) => AlertDialog(
                    title: TitleText('Error'),
                    content: SubtitleText(
                        'There was an error in creating the payment. Please try again with another card'),
                  ));
        });
      }
    } else {
      //case A
      StripePayment.cancelNativePayRequest();

      showDialog(
          context: context,
          builder: (BuildContext context) => AlertDialog(
                title: TitleText('Error'),
                content: SubtitleText(
                    'There was an error in creating the payment. Please try again with another card'),
              ));
    }
  }
}
