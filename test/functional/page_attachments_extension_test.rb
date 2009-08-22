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
        assert ActiveRecord::Base.included_modules.include?(ActiveRecord::Acts::List)
        assert Technoweenie::AttachmentFu

    assert UserActionObserver.methods.include?('observed_class')
    #assert_equal UserActionObserver.instance.observed_class, [User, Page, Layout, Snippet, Asset]
  end

end
