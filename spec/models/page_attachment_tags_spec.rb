require File.dirname(__FILE__) + '/../spec_helper'

describe "page attachment tags" do
  dataset :pages, :page_attachments
  
  it "should raise an error when required attributes missing" do
    [:url, :content_type, :size, :width, :height, :date, :image, :link, :author, :title].each do |key|
      message = "'name' attribute required"
      page.should render("<r:attachment:#{key} />").with_error(message)
    end
  end
  
  it "<r:attachment /> should render nothing when empty" do
    page.should render("<r:attachment></r:attachment>").as("")
  end
  
  it "should render the URL tag" do
    page.should render('<r:attachment:url name="rails.png" />').as(img.public_filename)
  end
  it "should render the title tag" do
    page.should render('<r:attachment:title name="rails.png" />').as(img.title)
  end
  it "should render the content type" do
    page.should render('<r:attachment:content_type name="rails.png" />').as(img.content_type)
  end

  it "should render the size" do
    page.should render('<r:attachment:size name="rails.png" />').as(img.size.to_s)
  end
  it "should render the size in bytes when unit is invalid" do
    page.should render('<r:attachment:size name="rails.png" units="blargobytes" />').as(img.size.to_s)
  end
  it "should render the size in the units specified" do
    page.should render('<r:attachment:size name="rails.png" units="kilobytes" />').as('%.2f' % (img.size / 1024.00))
  end

  it "should render the width" do
    page.should render('<r:attachment:width name="rails.png" />').as(img.width.to_s)
  end
  it "should render the height" do
    page.should render('<r:attachment:height name="rails.png" />').as(img.height.to_s)
  end
  it "should render the date" do
    page.should render('<r:attachment:date name="rails.png" format="%Y-%m-%d" />').as(img.created_at.strftime("%Y-%m-%d"))
  end
  it "should render the author" do
    page.should render('<r:attachment:author name="rails.png" />').as(img.created_by.name)
  end
  it "should render empty width and height for non-images" do
    page.should render('<r:attachment:height name="foo.txt"/>').as("")
    page.should render('<r:attachment:width name="foo.txt"/>').as("")
  end
  
  private

    def page(symbol = nil)
      if symbol.nil?
        @page ||= pages(:first)
      else
        @page = pages(symbol)
      end
    end
    def img
      page_attachments(:rails_png)
    end
    def txt
      page_attachments(:foo_txt)
    end
  
end
