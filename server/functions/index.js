const functions = require("firebase-functions");
const stripe = require('stripe')(functions.config().stripe.testkey)

const generateResponse = function (intent) {
    switch (intent.status) {
        case 'requires_action':
            return {
                clientSecret: intent.client_secret,
                requiresAction: true,
                status: intent.status,
            };
        case 'requires_payment_method':
            return {
                'error': 'Your card was denied, please provide a new payment method',
            };
        case 'succeeded':
            console.log('Payment succeeded.');
            return { clientSecret: intent.client_secret, status: intent.status, };
    }
    return { error: 'Failed' };
}

exports.StripePayEndpointMethodId = functions.https.onRequest(async (req, res) => {
    const { paymentMethodId, currency, useStripeSdk, amount, } = req.body;

    try {
        if (paymentMethodId) {
            // Create a new PaymentIntent
            const params = {
                amount: amount,
                confirm: true,
                confirmation_method: 'manual',
                currency: currency,
                payment_method: paymentMethodId,
                use_stripe_sdk: useStripeSdk,
            }
            const intent = await stripe.paymentIntents.create(params);
            console.log(`Intent: ${intent}`);
            return res.send(generateResponse(intent));
        }
        return res.sendStatus(400)
    } catch (e) {
        return res.send({ error: e.message });
    }
});
