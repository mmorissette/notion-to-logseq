RSpec.describe NotionToLogseq::MarkdownConverter do
  describe "#transform_link" do
    it "converts page links to logseq format" do
      notion_page_link = "[Page name](Export%207ae1874b01794d9d9daf1d4b84f16859/Page%20Name%20eb044120a8dc49d2b71c4f1c452f3d1e.md)"
      converter = NotionToLogseq::MarkdownConverter.new
      expect(converter.transform_link(notion_page_link)).to eq("[[Page name]]")
    end

    it "does not modify urls" do
      link = "[Google](https://google.com)"
      converter = NotionToLogseq::MarkdownConverter.new
      expect(converter.transform_link(link)).to eq(link)
    end
  end
end
