require 'rspec/rails'

Dir[Rails.root.join('spec', 'support', '**', '*.rb')].sort.each do |f|
  require f
end
