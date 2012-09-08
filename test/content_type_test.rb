require 'helper'

class ContentTypeTest < Test::Unit::TestCase
  context "Assigning a StringIO attachment" do
    setup do
      rebuild_model
      @file  = StringIO.new("abc")
      @file.stubs(:original_filename).returns("5k.png\n\n")
      @file.stubs(:content_type).returns("image/png\n\n")
      @file.stubs(:to_tempfile).returns(@file)
      @dummy = Dummy.new
      @dummy.avatar = @file
    end

    should "set content_type based on file magic" do
      assert_equal "text/plain", @dummy.avatar.content_type
      assert_equal "text/plain", @dummy.avatar_content_type
    end
  end

  context "Assigning a ZIP upfile attachment" do
    setup do
      rebuild_model
      @file = File.new File.join( FIXTURES_DIR, 'zip_file_called.txt' )
      @file.stubs(:content_type).returns("") # Some versions of chrome do this
      @dummy = Dummy.new
      @dummy.avatar = @file
    end

    should "set content_type based on file magic" do
      assert_equal "application/zip", @dummy.avatar.content_type
      assert_equal "application/zip", @dummy.avatar_content_type
    end
  end

  context "Assigning a URI" do
    setup do
      rebuild_model
      FakeWeb.register_uri(:get, "http://foo.bar/avatar", :body => "o(^_^)o", :content_type => "image/png")
      @dummy = Dummy.new
      @dummy.avatar = URI.parse("http://foo.bar/avatar")
    end

    should "not invoke file magic, maintaining the content_type from the response" do
      assert_equal "text/plain", @dummy.avatar.content_type
      assert_equal "text/plain", @dummy.avatar_content_type
    end
  end
end
