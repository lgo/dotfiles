# typed: true
# frozen_string_literal: true

require_relative "./library/Rx"
require "pathname"

module Dotfiles
  class Topic
    attr_accessor :shortname
    attr_accessor :name
    attr_accessor :path
    attr_accessor :symlinks
    attr_accessor :disabled
    attr_accessor :scripts

    def initialize(shortname, name, path, symlinks, scripts, disabled)
      self.shortname = shortname
      self.name = name
      self.path = path
      self.symlinks = symlinks
      self.scripts = scripts
      self.disabled = disabled
    end

    def dir
      Pathname.new(path).dirname.to_s
    end

    def absolute_dir
      File.expand_path(Pathname.new(path).dirname.to_s)
    end

    def self.read(root_path, path, validator: nil)
      if validator.nil?
        validator ||= Dotfiles::Validator.new
      end

      begin
        yaml = validator.load_and_check!(path)
        name = yaml["name"]
        disabled = yaml.fetch("disabled", false)
      rescue
        puts "ERROR: error when parsing file=#{path}"
        raise
      end

      short_path = path[root_path.size + 1..-1]
      shortname = short_path.match(/(.+)\/topic.yaml/)[1]

      topic_dir = Pathname.new(path).dirname.to_s
      symlinks = yaml.fetch("symlinks", []).map do |entry|
        SymlinkEntry.new(entry["src"], topic_dir, entry["path"])
      end

      scripts = yaml.fetch("scripts", []).map do |entry|
        ScriptEntry.new(entry["name"], topic_dir, entry["file"], entry.fetch("bootstrap", false))
      end

      Topic.new(shortname, name, path, symlinks, scripts, disabled)
    end
  end

  class SymlinkEntry
    attr_accessor :src
    attr_accessor :base_path
    attr_accessor :path

    def initialize(src, base_path, path)
      self.src = src
      self.base_path = base_path
      self.path = path
    end

    def is_installed?
      link_target = File.expand_path(path)
      link_source = File.join(base_path, src)
      FileTest.symlink?(link_target) && File.readlink(link_target) == link_source
    end

    def has_conflict?
      link_target = File.expand_path(path)
      FileTest.symlink?(link_target) || FileTest.exist?(link_target)
    end
  end

  class ScriptEntry
    attr_accessor :name
    attr_accessor :base_path
    attr_accessor :file
    attr_accessor :bootstrap

    def initialize(name, base_path, file, bootstrap)
      self.name = name
      self.base_path = base_path
      self.file = file
      self.bootstrap = bootstrap
    end

    def full_path
      File.join(base_path, file)
    end
  end
end
