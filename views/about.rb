require 'nokogiri'
require_relative 'common/setting.rb'
require_relative 'common/buttons.rb'
require_relative 'common/picture.rb'

module View
  class About
    def self.show
      error = Nokogiri::HTML::Builder.new do |doc|
        doc.html do
          doc.head do
            Setting.define_head(doc, title: 'About')
          end

          doc.body Setting.body  do
            Setting.main_navbar(doc)

            doc.div Setting.container do
              Setting.jumbotron(
                doc,
                head: 'More about this web app',
                body: 'This web application is written for a training purpose.'
              )

              Setting.title_h2(doc, 'Language')
              doc.p 'This web app was written in Ruby.'

              Picture.enigma(doc)

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
