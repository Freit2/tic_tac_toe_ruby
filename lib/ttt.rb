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
end