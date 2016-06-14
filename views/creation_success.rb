require 'nokogiri'
require_relative 'common/setting.rb'
require_relative 'common/buttons.rb'
require_relative 'common/text.rb'

module View
  class CreationSuccess
    def self.show(id)
      creation_success = Nokogiri::HTML::Builder.new do |doc|
        doc.html do
          doc.head do
            Setting.define_head(doc, title: "Notes - creation success")
          end

          doc.body Setting.body  do
            Setting.main_navbar(doc)

            doc.div Setting.container do
              Setting.jumbotron(
                doc,
                head: 'Note saved!',
                body: 'Your note have been successfully saved.'
              )

              Setting.title_h2(doc, "Your note ID")
              doc.p "Here is your note ID, do not lose it, as it will be asked in order to retrieve your note"
              doc.p "#{id}"

              Picture.success(doc)

              doc.form :action => '/', :method => 'GET', :class => 'form-horizontal' do
                Button.confirm(doc, type: 'success', value: 'GO HOME')
              end

            end
          end
        end
      end
      [creation_success.to_html]
    end
  end
end
