# -*- coding: utf-8 -*-
require "rspec/core/rake_task"

RSpec::Core::RakeTask.new("spec")
task :default => :spec

desc 'GitHub Blog から一番新しいインデックスページの HTML をダウンロードする'
task :download_latest_page do
  require 'nokogiri'

  # HTML 置き場
  Dir.mkdir('tmp') unless Dir.exists?('tmp')

  `wget https://github.com/blog -O ./tmp/latest.html`
end
