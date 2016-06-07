require 'nokogiri'
require_relative 'setting.rb'
require_relative 'buttons.rb'

module View
  class Welcome
    def self.show
      welcome = Nokogiri::HTML::Builder.new do |doc|
        doc.html do
          doc.head do
            Setting.define_head(doc, title: "Notes")
          end

          doc.body Setting.body  do
            Setting.main_navbar(doc)

            doc.div Setting.container do
              Setting.jumbotron(
                doc,
                head: 'What do you want to do?',
                body: 'You can create notes or access to one with ID and password.'
              )

              doc. form :action => '/creation', :method => 'GET', :class => 'form-horizontal' do
                Button.confirm(doc, type: 'form', value: 'Create Note')
              end

              doc. form :action => '/retrieval', :method => 'GET', :class => 'form-horizontal' do
                Button.confirm(doc, type: 'form', value: 'Retrieve Note')
              end

            end
          end
        end
      end
      [welcome.to_html]
    end
  end
end
