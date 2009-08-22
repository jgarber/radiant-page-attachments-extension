class PageAttachmentsDataset < Dataset::Base
  uses :pages, :users
  
  def load
    create_page_attachment "Rails Logo", :filename => "rails.png", :content_type => "image/png", :width => 50, :height => 64, :description => "The awesome Rails logo."
    create_page_attachment "Simple text file", :filename => "foo.txt", :content_type => "text/plain", :width => 50, :height => 64, :description => "Nice shootin', text."
  end
  
  helpers do
    def create_page_attachment(title, attributes={})
      create_record :page_attachment, title.symbolize, page_attachment_params(attributes.reverse_merge(:title => title))
    end
    
    def page_attachment_params(attributes={})
      title = attributes[:title] || unique_page_attachment_title
      { 
        :title => title,
        :size => File.join(File.dirname(__FILE__), '/files/', attributes[:filename]).size,
        :position => position(title),
        :page => pages(:first),
        :created_by => users(:admin)
      }.merge(attributes)
    end
    
    private
    
      @@unique_page_attachment_title_call_count = 0
      def unique_page_attachment_title
        @@unique_page_attachment_title_call_count += 1
        "page_attachment-#{@@unique_page_attachment_title_call_count}"
      end
      
      @@positions = Hash.new(0)
      def position(title)
        @@positions[title] += 1
      end
  end
  
end