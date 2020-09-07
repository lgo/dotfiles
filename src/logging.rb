# typed: true
# frozen_string_literal: true

require 'yaml'
require 'fileutils'
require 'io/console'
require 'fileutils'

module Dotfiles
  module Logging
    include Kernel

    def prompt
      case $stdin.getch
        when "b" then :backup
        when "o" then :overwrite
        when "s" then :skip
        else nil
      end
    end

    def log_info(msg)
      puts "\r  [ \033[00;34m..\033[0m ] #{msg}\n"
    end
    
    def log_user(msg)
      puts "\r  [ \033[0;33m??\033[0m ] #{msg}\n"
    end
    
    def prompt_user(msg)
      puts "\r  [ \033[0;33m??\033[0m ] #{msg}\n"
      result = prompt
      if result.nil?
        puts "Invalid character. (one more attempt)\n"
        result = prompt
      end
      if result.nil?
        raise ArgumentError.new("provided invalid character.")
      end
      result
    end
    
    def log_success(msg)
      puts "\r\033[2K  [ \033[00;32mOK\033[0m ] #{msg}\n"
    end
    
    def log_fail(msg)
      puts "\r\033[2K  [\033[0;31mFAIL\033[0m] #{msg}\n"
      exit(1)
    end
  end
end
