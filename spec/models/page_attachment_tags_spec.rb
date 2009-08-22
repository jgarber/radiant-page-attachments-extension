require File.dirname(__FILE__) + '/../spec_helper'

describe "page attachment tags" do
  dataset :pages, :page_attachments

  before :each do
    @img = page_attachments(:rails_png)
    @txt = page_attachments(:foo_txt)
  end
  
  it "should raise an error when required attributes missing" do
    [:url, :content_type, :size, :width, :height, :date, :image, :link, :author, :title].each do |key|
      message = "'name' attribute required"
      page.should render("<r:attachment:#{key} />").with_error(message)
      
    end
  end
  
  private

    def page(symbol = nil)
      if symbol.nil?
        @page ||= pages(:first)
      else
        @page = pages(symbol)
      end
    end
  
end
