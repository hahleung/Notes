require 'nokogiri'
require_relative 'common/setting.rb'
require_relative 'common/buttons.rb'
require_relative 'common/text.rb'

module View
  class Retrieval
    def self.show
      retrieval = Nokogiri::HTML::Builder.new do |doc|
        doc.html do
          doc.head do
            Setting.define_head(doc, title: "Notes - retrieval")
          end

          doc.body Setting.body  do
            Setting.main_navbar(doc)

            doc.div Setting.container do
              Setting.jumbotron(
                doc,
                head: 'Retrieval a note',
                body: 'Please the appropriate information in order to retrieve a note.'
              )

              doc. form :action => '/retrieval', :method => 'POST', :class => 'form-horizontal' do
                View::Text.form(
                  doc,
                  label: 'ID',
                  placeholder: 'If you have created a note, an ID was given to you',
                  name: 'id'
                )
                View::Text.form(
                  doc,
                  label: 'Password',
                  placeholder: 'You have lock your note with a password... Theoretically.',
                  name: 'password'
                )
                Button.confirm(doc, type: 'hidden', value: 'Retrieve note')
              end

              doc.form :action => '/', :method => 'GET', :class => 'form-horizontal' do
                Button.confirm(doc, type: 'form', value: 'GO HOME')
              end

            end
          end
        end
      end
      [retrieval.to_html]
    end
  end
end
