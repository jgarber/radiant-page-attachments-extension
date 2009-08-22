require File.dirname(__FILE__) + '/../test_helper'

class PageAttachmentsExtensionTest < Test::Unit::TestCase

  fixtures :page_attachments, :pages, :users
  test_helper :pages, :render

  # Replace this with your real tests.
  def setup
    @page = pages(:homepage)
  end

  def test_initialization
    assert_equal RAILS_ROOT + '/vendor/extensions/page_attachments', PageAttachmentsExtension.root
    assert_equal 'Page Attachments', PageAttachmentsExtension.extension_name
  end

  def test_module_inclusion
    assert Page.included_modules.include?(PageAttachmentTags)
    assert Page.included_modules.include?(PageAttachmentAssociations)
    assert UserActionObserver.included_modules.include?(ObservePageAttachments)
        assert ActiveRecord::Base.included_modules.include?(ActiveRecord::Acts::List)
        assert Technoweenie::AttachmentFu

    assert UserActionObserver.methods.include?('observed_class')
    #assert_equal UserActionObserver.instance.observed_class, [User, Page, Layout, Snippet, Asset]
  end

  def test_positions
          img = page_attachments(:rails_png)
          txt = page_attachments(:foo_txt)
          assert_equal 1, img.position
          assert_equal 2, txt.position
          img.move_lower
          txt.reload
          assert_equal 2, img.position
          assert_equal 1, txt.position
  end

  def test_attachment_inheritance
    @page = pages(:documentation)
    img = page_attachments(:rails_png)
    txt = page_attachments(:foo_txt)
    assert_renders img.public_filename, '<r:attachment:url name="rails.png" />', '/documentation'
    assert_renders txt.public_filename, '<r:attachment:url name="foo.txt" />', '/documentation'
  end

  def test_filter_by_extension
    assert_renders "rails.png", %{<r:attachment:each extensions="png"><r:filename/></r:attachment:each>}
    assert_renders "rails.pngfoo.txt", %{<r:attachment:each extensions="png|txt"><r:filename/></r:attachment:each>}
  end

  def test_if_attachment_tag
    assert_renders "content", %{<r:if_attachments>content</r:if_attachments>}
    assert_renders "", %{<r:if_attachments min_count="3">content</r:if_attachments>}
    assert_renders "content", %{<r:if_attachments min_count="1" extensions="png">content</r:if_attachments>}
  end

  def test_extension_tag
    assert_renders "pngtxt", %{<r:attachment:each><r:extension/></r:attachment:each>}
  end
end
