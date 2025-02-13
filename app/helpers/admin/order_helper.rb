module Admin
  module OrdersHelper
    def order_status_badge(status)
      classes = {
        'pending' => 'bg-yellow-100 text-yellow-800',
        'processing' => 'bg-blue-100 text-blue-800',
        'shipped' => 'bg-green-100 text-green-800',
        'delivered' => 'bg-green-200 text-green-900',
        'cancelled' => 'bg-red-100 text-red-800'
      }
      
      content_tag(:span, status.titleize, class: "px-2 inline-flex text-xs leading-5 font-semibold rounded-full #{classes[status] || 'bg-gray-100 text-gray-800'}")
    end
  end
end