from django.http import JsonResponse
from django.views.generic import DetailView

from api.models import Item
from api.stripe_service import StripeHelper
from app.services import HTTPStatusCode


class ItemGetSession(DetailView):
    model = Item

    def get(self, request, *args, **kwargs):
        item = self.get_object()

        session_id = StripeHelper().get_session_id_for_product(
            name=item.name,
            price=item.price
        )

        return JsonResponse(session_id, status=HTTPStatusCode.OK)
