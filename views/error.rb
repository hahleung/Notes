require 'nokogiri'
require_relative 'common/setting.rb'
require_relative 'common/buttons.rb'
require_relative 'common/picture.rb'

module View
  class Error
    def self.show(message)
      error = Nokogiri::HTML::Builder.new do |doc|
        doc.html do
          doc.head do
            Setting.define_head(doc, title: "Error!")
          end

          doc.body Setting.body  do
            Setting.main_navbar(doc)

            doc.div Setting.container do
              Setting.jumbotron(
                doc,
                head: 'Badrequest!',
                body: "An error has occured, please review your inputs."
              )

              doc.text message

              Picture.error(doc)

              doc.form :action => '/', :method => 'GET', :class => 'form-horizontal' do
                Button.confirm(doc, type: 'home', value: 'GO HOME')
              end

            end
          end
        end
      end
      [error.to_html]
    end
  end
end
