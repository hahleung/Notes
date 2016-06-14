require 'mongo'

module Storage
  class MongoStore
    def self.connection
      host = ENV['MONGODB_URI'] || ['127.0.0.1:27017']
      client = Mongo::Client.new(host)
      client['notes']
    end

    def self.save(id, note)
      collection = MongoStore.connection
      collection.insert_one(id)
      collection.find(id).update_one(note.merge(id))
    end

    def self.read(id, password)
      collection = MongoStore.connection
      documents = collection.find.map { |x| x }
      documents.select do |doc|
        doc.value?(id.values.first)
      end.first
    end
  end
end
