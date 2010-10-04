module TicTacToeEngine
  module TTT
    class Config
      attr_accessor :data

      def initialize(data={})
        @data = {}
        update!(data)
      end

      def update!(data)
        data.each do |key, value|
          self[key] = value
        end
      end

      def length
        @data.length
      end

      def [](key)
        @data[key.to_sym]
      end

      def []=(key, value)
        if value.class == Hash
          @data[key.to_sym] = Config.new(value)
        else
          @data[key.to_sym] = value
        end
      end

      def keys
        return @data.keys
      end

      def values
        return @data.values
      end

      def index(value)
        return @data.index(value)
      end

      def active
        actives = []
        self.keys.each do |key|
          actives << key.to_s if self[key][:active]
        end
        return actives
      end

      def method_missing(sym, *args)
        if sym.to_s =~ /(.+)=$/
          self[$1] = args.first
        else
          self[sym]
        end
      end
    end

    CONFIG = Config.new

    def self.add_cache(key)
      case CONFIG.boards[key][:cache]
      when :hash
        CONFIG.cache.update!({:hash => HashCache.new})
      when :mongo
        if MongoCache.db_installed?
          CONFIG.cache.update!({:mongo => MongoCache.new})
        else
          CONFIG.boards[key][:active] = false
        end
      else
        CONFIG.cache.update!({CONFIG.boards[key][:cache] => NilCache.new})
      end
    end

    def self.initialize_cache
      CONFIG.boards.active.each do |key|
        add_cache(key)
      end
    end
  end
end
