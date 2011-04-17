# Released under MIT License
# Copyright (c) 2011 Ash Berlin and DigiResults Ltd.

require 'filemagic'
require 'paperclip'

require 'paperclip-filemagic/railtie'

module Paperclip
  def self.magic_content_type!
    Attachment.send :include, FileMagic
  end

  module FileMagic
    def self.included( base )
      base.class_eval do
        alias_method :assign_without_filemagic, :assign
        alias_method :assign, :assign_with_filemagic
      end
    end

    def assign_with_filemagic( uploaded_file )
      # Call next method up the chain
      val = assign_without_filemagic( uploaded_file )

      return val if uploaded_file.is_a?( Paperclip::Attachment )

      if uploaded_file
        magic = ::FileMagic.new( ::FileMagic::MAGIC_MIME )

        if defined?( StringIO ) && uploaded_file.is_a?( StringIO )
          type = magic.buffer( uploaded_file.string )
        else
          type = magic.file( uploaded_file.path )
        end

        # Remove the '; charset=us-ascii' from the end if there is one
        type.sub! /\s*;.*$/, ''

        instance_write( :content_type, type )
      end
      val
    ensure
      magic.close if magic
    end
  end
end
