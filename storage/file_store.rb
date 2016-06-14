require 'yaml'
require_relative '../control/errors/errors.rb'
require_relative '../control/notes.rb'

module Storage
  class FileStore
    def self.save(id, note)
      File.write("#{id}.yml", note.to_yaml)
    end

    def self.read(id, password)
      files = Dir.glob('*{yml}')
      file_name = "#{id}.yml"
      raise Error::IDNotFound unless files.include?(file_name)

      file = YAML.load(File.read(file_name))
      if file[Control::PASSWORD] == password
        file
      else
        raise Error::AccessDenied
      end
    end
  end
end
