# Paperclip::FileMagic

[Paperclip] is a wonderful module by Thoughtbot that lets makes handling
attachments in Rails a breeze, except for one minor niggle - file types. It
relies on the content type header sent by the browser which is woefully
inconsistent. For example, when uploading a zip the possible values sent
for content type are:

+ '`application/octet-stream`'
+ '`application/x-zip-compressed`'
+ '`application/zip`'
+ '' (yes empty)

In short you can't rely on Content-Type from the browser to ever have a
sensible value.

Thus the purpose of this module: it uses the wonderful
[libmagic](http://www.darwinsys.com/file/) to work out the file type based
on the contents of the uploaded file without shelling out to `file` to do its
work.

# Requirements

The ruby-filemagic gem (which this gem uses) depends upon `libmagic` must be
installed to give us file type detection. On Linux this means installing the
relevant package:

    sudo apt-get install libmagic-dev # Deb
    sudo yum install file-devel # rpm
    sudo emerge file # gentoo

On OSX ships with the `file` binary but not the `libmagic` shared library so I
recommend installing it via [homebrew]:

    brew install libmagic
    # Since this will be in a non-standard place we need to build ruby-filemagic specially
    gem install ruby-filemagic -- --with-opt-dir=/usr/local/Cellar/libmagic/5.04/

# Installation

Include the gem in your Gemfile:

    gem 'paperclip-filemagic'

# Usage

Its all automatic - paperclip-filemagic does its trick by just being in the Gemfile.

When a Paperclip attachment is assigned to its content_type will be detected
and will overwrite what the browser sends.

# Caveats/Bugs

libmagic often returns charset info or similar for files (i.e. `text/plain;
charset=us-asci`) that this module attempts to remove to use just the base
type. Supposedly older versions of libmagic might return this in a
different format and thus not get removed. If you find an example of this
happening please let me know.

# Credits & License

![digiresults](https://www.digiresults.com/stylesheets/images/logo_white.png)

This gem was developed for use at [DigiResults] and pulled out into a reusable gem.

Released under the [MIT License][MIT]

Copyright (c) 2011, Ash Berlin and DigiResults Ltd.

[Paperclip]: http://github.com/thoughtbot/paperclip
[homebrew]: http://mxcl.github.com/homebrew/
[MIT]: http://creativecommons.org/licenses/MIT/
[DigiResults]: http://www.digiresults.com/
