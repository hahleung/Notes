require 'nokogiri'
require_relative 'common/setting.rb'
require_relative 'common/buttons.rb'
require_relative 'common/text.rb'

module View
  class RetrievalSuccess
    def self.show(title, body)
      retrieval_success = Nokogiri::HTML::Builder.new do |doc|
        doc.html do
          doc.head do
            Setting.define_head(doc, title: "Notes - retrieval success")
          end

          doc.body Setting.body  do
            Setting.main_navbar(doc)

            doc.div Setting.container do
              Setting.jumbotron(
                doc,
                head: 'Retrieval successful!',
                body: 'Please, find your note below.'
              )

              Setting.title_h2(doc, "Title")
              doc.p "#{title}"

              Setting.title_h2(doc, "Body")
              doc.p "#{body}"

              doc.form :action => '/', :method => 'GET', :class => 'form-horizontal' do
                Button.confirm(doc, type: 'form', value: 'GO HOME')
              end

            end
          end
        end
      end
      [retrieval_success.to_html]
    end
  end
end
