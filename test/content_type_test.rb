require 'helper'

class ContentTypeTest < Test::Unit::TestCase
  context "Assigning an attachment" do
    setup do
      rebuild_model :styles => { :something => "100x100#" }
      @file  = StringIO.new(".")
      @file.stubs(:original_filename).returns("5k.png\n\n")
      @file.stubs(:content_type).returns("image/png\n\n")
      @file.stubs(:to_tempfile).returns(@file)
      @dummy = Dummy.new
      Paperclip::Thumbnail.expects(:make).returns(@file)
      @attachment = @dummy.avatar
      @dummy.avatar = @file
    end

    should "set content_type based on file magic" do
      assert_equal "text/plain", @dummy.avatar.content_type
    end
  end
end
