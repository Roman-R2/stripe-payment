import decimal
import os

import stripe
from dotenv import load_dotenv

load_dotenv('.env.dev')


class StripeHelper:
    stripe_obj = stripe

    def __init__(self):
        self.stripe_obj.api_key = os.getenv('STRIPE_SECRET_KEY', None)

    def get_session_id_for_product(self, name: str, price: decimal):
        """ Return stripe session data for received product data. """
        stripe_session = self.stripe_obj.checkout.Session.create(
            line_items=self.get_line_items(name, price),
            mode='payment',
            success_url=os.getenv('STRIPE_SUCCESS_URL', None),
            cancel_url=os.getenv('STRIPE_CANSEL_URL', None),
        )

        return stripe_session

    def get_line_items(self, name: str, price: decimal, currency: str = 'usd', quantity: int = 1):
        """ Return structed list of line items."""
        converted_price = ''.join([str(digit) for digit in price.as_tuple().digits])
        return [{
            'price_data': {
                'currency': currency,
                'product_data': {
                    'name': name,
                },
                'unit_amount': converted_price,
            },
            'quantity': quantity,
        }]
