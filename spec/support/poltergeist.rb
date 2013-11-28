## https://gist.github.com/ericboehs/7125105

puts "! Make sure `require \'capybara/poltergeist\'` is before loading #{__FILE__}" unless defined? Capybara::Poltergeist
module Capybara::Poltergeist
  class Client
    private
    def redirect_stdout
      prev = STDOUT.dup
      prev.autoclose = false
      $stdout = @write_io
      STDOUT.reopen(@write_io)

      prev = STDERR.dup
      prev.autoclose = false
      $stderr = @write_io
      STDERR.reopen(@write_io)
      yield
    ensure
      STDOUT.reopen(prev)
      $stdout = STDOUT
      STDERR.reopen(prev)
      $stderr = STDERR
    end
  end
end

class WarningSuppressor
  class << self
    def write(message)
      case message
      when /QFont::setPixelSize: Pixel size <= 0/
      when /CoreText performance note:/
      else
        puts(message)
      end
    end
  end
end

Capybara.register_driver :poltergeist do |app|
  Capybara::Poltergeist::Driver.new(app, js_errors: true, inspector: true, phantomjs_logger: WarningSuppressor)
end
