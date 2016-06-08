require 'nokogiri'
require_relative 'common/setting.rb'
require_relative 'common/buttons.rb'
require_relative 'common/text.rb'

module View
  class Creation
    def self.show
      creation = Nokogiri::HTML::Builder.new do |doc|
        doc.html do
          doc.head do
            Setting.define_head(doc, title: "Notes - creation")
          end

          doc.body Setting.body  do
            Setting.main_navbar(doc)

            doc.div Setting.container do
              Setting.jumbotron(
                doc,
                head: 'Create notes',
                body: 'Please fill the blanks, an ID will be given to you, do not loose it.'
              )

              doc. form :action => '/creation', :method => 'POST', :class => 'form-horizontal' do
                View::Text.form(
                  doc,
                  label: 'Title',
                  placeholder: 'Write a title for your note',
                  name: 'title'
                )
                View::Text.form(
                  doc,
                  label: 'Body',
                  placeholder: 'Write a body for your note',
                  name: 'body'
                )
                View::Text.form(
                  doc,
                  label: 'Password',
                  placeholder: 'Write a password for your note',
                  name: 'password'
                )
                Button.confirm(doc, type: 'hidden', value: 'Create Note')
              end

            end
          end
        end
      end
      [creation.to_html]
    end
  end
end
