require 'uri'

module NotionToLogseq
  class MarkdownConverter
    LINK_MATCHER = /\[(.*?)\]\((.*?)\)/

    def transform_link(link)
      return link unless page_link?(link)
      transform_page_link(link)
    end

    def page_link?(link)
      match = link.match(LINK_MATCHER)
      return false unless match
      _,link = match.captures
      URI(link).scheme.nil?
    end

    private

    def transform_page_link(page_link)
      match = page_link.match(LINK_MATCHER)
      title,_ = match.captures
      "[[#{title}]]"
    end
  end
end
