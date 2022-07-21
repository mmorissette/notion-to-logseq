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
      !!match
    end

    private

    def transform_page_link(page_link)
      match = page_link.match(LINK_MATCHER)
      return page_link unless match

      title,link = match.captures
      return page_link if URI(link).scheme

      "[[#{title}]]"
    end
  end
end
