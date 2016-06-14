module View
  class Text
    def self.form(doc, label:, placeholder:, name:)
      doc.div :class => "form-group" do
        doc.label label, :class => "col-sm-2 control-label", :style => "padding-top:6px"
        doc.div :class => "col-sm-10" do
          doc.input :type => 'text', :autocomplete => 'off', :class => "form-control", :placeholder => placeholder, :name => name
        end
      end
    end
  end

  class Text_body
    def self.form(doc, label:, placeholder:, name:)
      doc.div :class => "form-group" do
        doc.label label, :class => "col-sm-2 control-label", :style => "padding-top:6px"
        doc.div :class => "col-sm-10" do
          doc.textarea :class => 'form-control', :autocomplete => 'off', :rows => '5', :placeholder => placeholder, :name => name
        end
      end
    end
  end

  class Text_password
    def self.form(doc, label:, placeholder:, name:)
      doc.div :class => "form-group" do
        doc.label label, :class => "col-sm-2 control-label", :style => "padding-top:6px"
        doc.div :class => "col-sm-10" do
          doc.input :type => 'password', :autocomplete => 'off', :class => "form-control", :placeholder => placeholder, :name => name
        end
      end
    end
  end
end
