# frozen_string_literal: true

# My comment
module ApplicationHelper
  def edit_and_destroy_buttons(item)
    # if current_user.nil?
    edit = link_to('Edit', url_for([:edit, item]), class: "btn btn-primary") if current_user
    # unless current_user.admin.nil?
    del = link_to('Destroy', item, method: :delete,
                                   data: { confirm: 'Are you sure?' },
                                   class: "btn btn-danger")
    raw("#{edit} #{del}") if current_user.admin
    # end
    # end
  end

  def round(number)
    number_with_precision(number, precision: 1)
  end
end
