import os

from django.shortcuts import get_object_or_404
from django.views.generic import TemplateView

from api.models import Item


class Index(TemplateView):
    template_name = 'web/index.html'


class ItemGetHtmlForm(TemplateView):
    template_name = 'web/item.html'

    def get_context_data(self, **kwargs):
        context_data = super().get_context_data(**kwargs)

        queryset = get_object_or_404(Item, pk=context_data['pk'])

        return {
            'item': queryset,
            'stripe_public_key': os.getenv('STRIPE_PUBLISH_KEY', '')
        }
