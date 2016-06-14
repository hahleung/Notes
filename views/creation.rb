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
                head: 'Creating notes',
                body: 'Please fill the blanks, an ID will be given to you, do not lose it.'
              )

              Setting.title_h2(doc, "Some useful information")
              doc.p 'The content of your note is encrypted in storage with random key AES-128-CBC. The access to this key is possible by given the ID and the password of the note.'
              doc.p "Your password is detroyed at the very moment you're submitting contents. Simply, don't lose it, because passwords aren't stored; precisely, passwords are hashed with MD5 function."

              Setting.title_h2(doc, "Creating notes!")
              doc.form :action => '/creation', :method => 'POST', :class => 'form-horizontal' do
                View::Text.form(
                  doc,
                  label: 'Title',
                  placeholder: 'Give a title to your note',
                  name: 'title'
                )
                View::Text_body.form(
                  doc,
                  label: 'Body',
                  placeholder: 'Write the content of your note',
                  name: 'body'
                )
                View::Text_password.form(
                  doc,
                  label: 'Password',
                  placeholder: 'Give a password for your note, do not lose it!',
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
