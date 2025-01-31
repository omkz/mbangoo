module ApplicationHelper
  def flash_classes(flash_type)
    flash_base = "px-2 py-4 mx-auto font-sans font-medium text-center text-white"
    {
      notice: "bg-sky-500 #{flash_base}",
      error:  "bg-red-600 #{flash_base}",
      alert: "bg-red-600 #{flash_base}"
    }.stringify_keys[flash_type.to_s] || flash_type.to_s
  end

  def form_error_notification(object)
    if object.errors.any?
      tag.div class: "px-3 py-2 mt-3 font-medium text-red-500 rounded-md bg-red-50" do
        object.errors.each do |error|
          concat content_tag(:li, error.full_message)
        end
      end
    end
  end
end
