require 'magic-paperclip'

module MagicPaperclip
  if defined? Rails::Railtie
    require 'rails'
    class Railtie < Rails::Railtie
      initializer 'magic-paperclip' do
        Paperclip.magic_content_type!
      end
    end
  end
end
