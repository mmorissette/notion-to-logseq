require_relative 'notion_page'

module NotionToLogseq
  class PageDiscovery
    attr_reader :root_dir
    attr_reader :unsupported_files

    def initialize(root_dir)
      @root_dir = root_dir
      @unsupported_files = []
    end

    def pages
      pages ||= find_pages(root_dir, NotionToLogseq::NotionPage.new("Root"))
    end

    def pretty_print
      recursive_print(pages, 0)
    end

    private

    def find_pages(dir, page)
      Dir.foreach(dir) do |entry|
        next if entry == "." || entry == ".."

        path = File.join(dir, entry)
        next if File.directory?(path)

        match = entry.match(/^(.*?) \w{32}(.*)$/)
        if match.nil?
          unsupported_files << path
          next
        end

        page_name, extension = match.captures
        if extension != ".md"
          unsupported_files << path
          next
        end

        child_page = NotionToLogseq::NotionPage.new(page_name, path)

        dir_path = path.slice(0...-3)
        if File.directory?(dir_path)
          find_pages(dir_path, child_page)
        end
        page.children << child_page
      end
      page.children
    end

    def recursive_print(pages, depth = 0)
      pages.each do |page|
        puts "#{"\t"*depth}#{page.logseq_name}"
        recursive_print(page.children, depth+1)
      end
    end
  end
end


root_dir = ARGV[0]
page_discovery = NotionToLogseq::PageDiscovery.new(root_dir)
page_discovery.pretty_print
