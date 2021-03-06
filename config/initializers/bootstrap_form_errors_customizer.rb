ActionView::Base.field_error_proc = proc do |html_tag, instance|
  class_attr_index = html_tag.index 'class="'

  if class_attr_index
    html_tag.insert class_attr_index + 7, 'is-invalid '
  else
    html_tag.insert html_tag.index('>'), ' class="is-invalid"'
  end
  if html_tag.starts_with?('<label')
    html_tag
  else
    html_tag << "<div class=\"invalid-feedback\">#{instance.error_message.first.humanize}</div>".html_safe
  end
end

module ActionView
  module Helpers
    module ActiveModelInstanceTag
      def error_message
        object.errors[@method_name.delete_suffix('_id')]
      end
    end
  end
end
