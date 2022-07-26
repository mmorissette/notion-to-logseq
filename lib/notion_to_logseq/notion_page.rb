module NotionToLogseq
  class NotionPage
    attr_reader :name, :path, :children

    def initialize(name, path = nil, children = [])
      @name = name
      @path = path
      @children = children
    end

    def logseq_name
      "[[#{name}]]"
    end
  end
end
