module Logable
  ERROR_PATH = 'logs/errors.log'.freeze

  def self.included(base)
    base.extend ClassMethods
  end

  module ClassMethods
    attr_accessor :log_path

    def read_file(file_path)
      return until file_path

      file = File.new(file_path)
      data = file.read
      puts data
      file.close
    end
  end

  protected

  def write_log(data)
    self.class.log_path ||= "logs/#{self.class}.log"
  
    File.open(self.class.log_path, 'a+') do |f|
      counter = 1
      f.each { counter += 1 }
      f.puts "#{counter}. #{data}"
    end
  end

  def write_error(message)
    File.open(ERROR_PATH, 'a') do |f|
      f.puts "[#{Time.now}] [#{self.class}] [#{message}]"
    end
  end
end
