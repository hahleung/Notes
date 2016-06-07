module View
  class Button
    def self.confirm(doc, type:, value:)
      align = type == "form" ? "col-sm-offset-2 col-sm-10" : "col-sm-10"
      doc.div :class => "form-group" do
        doc.div :class => align do
          doc.input :type => "submit", :class => "btn btn-success", :value => value
        end
      end
    end
end
end
