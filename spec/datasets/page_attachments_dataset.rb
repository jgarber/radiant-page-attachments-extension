class PageAttachmentsDataset < Dataset::Base
  uses :pages, :users
  
  def load
    create_page_attachment "rails.png", :title => "Rails Logo", :content_type => "image/png", :width => 50, :height => 64, :description => "The awesome Rails logo."
    create_page_attachment "foo.txt", :title => "Simple text file", :content_type => "text/plain", :width => 50, :height => 64, :description => "Nice shootin', text."
  end
  
  helpers do
    def create_page_attachment(filename, attributes={})
      create_record :page_attachment, filename.symbolize, page_attachment_params(attributes.reverse_merge(:filename => filename))
    end
    
    def page_attachment_params(attributes={})
      { 
        :size => File.join(File.dirname(__FILE__), '/files/', attributes[:filename]).size,
        :position => position(attributes[:filename]),
        :page => pages(:first),
        :created_by => users(:admin)
      }.merge(attributes)
    end
    
    private
      
      @@positions = Hash.new(0)
      def position(filename)
        @@positions[filename] += 1
      end
  end
  
end