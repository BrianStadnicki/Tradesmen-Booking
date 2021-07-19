ActionView::Base.field_error_proc = proc do |html_tag, _instance|
  class_attr_index = html_tag.index 'class="'

  if class_attr_index
    html_tag.insert class_attr_index + 7, 'is-invalid '
  else
    html_tag.insert html_tag.index('>'), ' class="is-invalid"'
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
