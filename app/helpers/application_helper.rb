module ApplicationHelper
  
  def link_to_add_fields(name, f, association, linkclass = '')
     new_object = f.object.send(association).klass.new
     id = new_object.object_id
     fields = f.fields_for(association, new_object, child_index: id) do |builder|
       render(association.to_s.singularize + "_fields", f: builder)
     end
     link_to(name, '#', class: "add_fields #{linkclass}", data: {id: id, fields: fields.gsub("\n", "")})
   end

  # Returns the full title on a per-page basis.
  def full_title(page_title)
    base_title = "GamePlayDate"
    if page_title.empty?
      base_title
    else
      "#{base_title} | #{page_title}"
    end
  end
end
