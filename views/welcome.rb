require 'nokogiri'
require_relative 'common/setting.rb'
require_relative 'common/buttons.rb'

module View
  class Welcome
    def self.show
      welcome = Nokogiri::HTML::Builder.new do |doc|
        doc.html do
          doc.head do
            Setting.define_head(doc, title: "Notes - Welcome")
          end

          doc.body Setting.body  do
            Setting.main_navbar(doc)

            doc.div Setting.container do
              Setting.jumbotron(
                doc,
                head: 'Welcome!',
                body: 'Here is a naive web application for storing notes and retrieving them with an ID and a password. So simple!'
              )

              Setting.title_h2(doc, "What do you want to do?")
              doc.p "Follow the tutorial if needed."

              Picture.welcome(doc)

              doc. form :action => '/creation', :method => 'GET', :class => 'form-horizontal' do
                Button.confirm(doc, type: 'welcome', value: 'Create Note')
              end

              doc. form :action => '/retrieval', :method => 'GET', :class => 'form-horizontal' do
                Button.confirm(doc, type: 'welcome', value: 'Retrieve Note')
              end

            end
          end
        end
      end
      [welcome.to_html]
    end
  end
end
