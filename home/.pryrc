Pry.config.pager = false

Pry.editor = 'nvim'

begin
  require 'awesome_print'
  AwesomePrint.pry!
rescue LoadError => err
end
