const functions = require("firebase-functions");
const admin = require('firebase-admin');
admin.initializeApp();
const db = admin.firestore();

// Stripe API End Point for secure payment
const stripe = require('stripe')(functions.config().stripe.publishablekey)

exports.StripePI = functions.https.onRequest(async (req, res) => { 
    stripe.paymentMethods.create(
        {
          payment_method: req.query.paym,
        }, {
          stripeAccount: stripeVendorAccount
        },
        function(err, clonedPaymentMethod) {
          if (err !== null){
            console.log('Error clone: ', err);
            res.send('error');
          } else {
            console.log('clonedPaymentMethod: ', clonedPaymentMethod);
            const fee = (req.query.amount/100) | 0;
            stripe.paymentIntents.create(
                {
                    amount: req.query.amount,
                    currency: req.query.currency,
                    payment_method: clonedPaymentMethod.id,
                    confirmation_method: 'automatic',
                    confirm: true,
                    application_fee_amount: fee,
                    description: req.query.description,
                }, {
                    stripeAccount: stripeVendorAccount
                },
                function(err, paymentIntent) {
                    // asynchronously called
                    const paymentIntentReference = paymentIntent;
                    if (err !== null){
                        console.log('Error payment Intent: ', err);
                        res.send('error');} else {
                        console.log('Created paymentintent: ', paymentIntent);
                        res.json({
                        paymentIntent: paymentIntent, 
                        stripeAccount: stripeVendorAccount});
                    }
                }
            );
        }
    });
});

// Functions for notifications onCreate of Events and Products documents in firestore.

exports.eventNotifications = functions.firestore.document('/events/{documentId}')
  .onCreate((snap, context) => {
    // Grab the current value of what was written to Firestore.
    const eventDoc = snap.data();
    // const tokens = []

    // Logging 
    functions.logger.log('Event Notification For :', context.params.documentId);


    // Getting all users tokens
    // var data = db.collection('users').get();
    // data.docs.forEach(async (e) => {
    //   var tok = await e.ref.collection('tokens').get();
    //   tok.forEach((e) => {
    //     tokens.push(e.get('tokenId'));
    //   })
    // })

    // Notification details.
    const payload = {
      notification: {
        title: 'New Event from V5!',
        body: `${eventDoc.title}`,
        icon: 'https://secureservercdn.net/198.71.189.253/jj2.c87.myftpupload.com/wp-content/uploads/2019/02/v5blueblue.png',
        imageUrl: eventDoc.imageUrl,
        clickAction: 'FLUTTER_NOTIFICATION_CLICK'
      }
    };

    return admin.messaging().sendToTopic('events', payload)

    // const response = await admin.messaging().sendMulticast({
    //   tokens: tokens,
    //   notification: payload.notification 
    // });
});

// Products

exports.productNotification = functions.firestore.document('products/{documentId}')
  .onCreate((snap, context) => {
    const product = snap.data();

   // Logging 
   functions.logger.log('Product Notification For :', context.params.documentId);

   const payload = {
    notification: {
      title: 'New Product from V5!',
      body: `${eventDoc.title}`,
      icon: 'https://secureservercdn.net/198.71.189.253/jj2.c87.myftpupload.com/wp-content/uploads/2019/02/v5blueblue.png',
      imageUrl: eventDoc.imageUrl,
      clickAction: 'FLUTTER_NOTIFICATION_CLICK'
    }
  };

  return admin.messaging().sendToTopic('events', payload)
   
  })