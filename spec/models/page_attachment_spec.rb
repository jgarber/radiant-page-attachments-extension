require File.dirname(__FILE__) + '/../spec_helper'

describe PageAttachment do
  dataset :pages, :page_attachments
  
  it "should change position when first attachment is moved lower" do
    img.position.should == 1
    txt.position.should == 2
    img.move_lower
    txt.reload
    img.position.should == 2
    txt.position.should == 1
  end
  
  def img
    page_attachments(:rails_png)
  end
  def txt
    page_attachments(:foo_txt)
  end
end