require 'paperclip-filemagic'

module Paperclip
  module Filemagic
    if defined? Rails::Railtie
      require 'rails'
      class Railtie < Rails::Railtie
        initializer 'paperclip.filemagic' do
          Paperclip.magic_content_type!
        end
      end
    end
  end
end
