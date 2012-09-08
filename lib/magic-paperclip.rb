# Released under MIT License
# Copyright (c) 2011 Ash Berlin and DigiResults Ltd.

require 'filemagic'
require 'paperclip'

require 'magic-paperclip/railtie'

module Paperclip
  def self.magic_content_type!
    Attachment.send :include, MagicPaperclip
  end
end

module MagicPaperclip
  def self.included( base )
    base.class_eval do
      alias_method :assign_without_filemagic, :assign
      alias_method :assign, :assign_with_filemagic
    end
  end

  def assign_with_filemagic( uploaded_file )
    assign_without_filemagic( uploaded_file ).tap do
      return unless uploaded_file
      return if uploaded_file.kind_of?( Paperclip::Attachment ) # Attachment#reprocess!

      io_adapter = self.queued_for_write[:original]

      begin
        magic = FileMagic.new( FileMagic::MAGIC_MIME )
        type = magic.file( io_adapter.path )
        type.sub! /\s*;.*$/, '' # Remove the '; charset=us-ascii' from the end if there is one
        instance_write( :content_type, type )
      ensure
        magic.close if magic
      end
    end
  end

end