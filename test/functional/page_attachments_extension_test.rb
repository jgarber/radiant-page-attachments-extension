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

end
