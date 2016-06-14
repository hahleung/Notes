require_relative 'mongo_store.rb'
require_relative 'file_store.rb'

module Storage
  class MainStore
    def initialize(store)
      @store = store
    end

    def save(id, note)
      @store.save(id, note)
    end

    def read(id, password)
      @store.read(id, password)
    end
  end
end
