# -*- coding: utf-8 -*-
require "rspec/core/rake_task"

RSpec::Core::RakeTask.new("spec")
# task :default => :spec

desc 'GitHub Blog から一番新しいインデックスページの HTML をダウンロードする'
task :download_latest_page do
  require 'nokogiri'

  # HTML 置き場
  Dir.mkdir('tmp') unless Dir.exists?('tmp')

  `wget https://github.com/blog -O ./tmp/latest.html`
end

desc 'entries.json をアップデートする'
task :update_entries do
  require 'json'
  require 'nokogiri'

  # 前回までに fetch 済みのエントリー情報をロードする
  entries = JSON.parse(open('entries.json').read)

  # 最新の HTML からエントリー情報を取り出す
  doc = Nokogiri::HTML(open('./tmp/latest.html'))
  new_entries = doc.search('.blog-post').map do |post|
    title     = post.search('.entry-title').first.text
    href      = post.search('.entry-title').first['href']
    published = post.search('.published').first['title']
    { title: title, href: href, published: published }
  end

  # 新しいエントリーがあれば entries に追加する
  new_entries.each do |entry|
    # entries に entry と同じ title, href, published を持つ要素が一つも無ければ (none) この条件が真となる
    if entries.none? { |e| e['title'] == entry['title'] && e['href'] == entry['href'] && e['published'] == entry['published'] }
      entries.unshift entry
    end
  end

  open('entries.json', 'w'){ |f|
    f.puts JSON.pretty_generate(entries.flatten)
  }
end

desc 'entries.json をアップデートしてから rake spec する'
task :do_spec => :update_entries do
  Rake::Task['spec'].invoke
end
task :default => :do_spec
