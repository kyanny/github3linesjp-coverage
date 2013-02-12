#!/usr/bin/env ruby
# -*- coding: utf-8 -*-
require 'open-uri'
require 'nokogiri'

url = ARGV.shift
doc = Nokogiri::HTML(open(url))
doc.search('.blog-post').map do |post|
  title     = post.search('.entry-title').first.text
  href      = post.search('.entry-title').first['href']
  published = post.search('.published').first['title']
  puts <<META
#{href.sub(/\/blog\//, '')}

出典: [#{title} - GitHub Blog](https://github.com#{href})

#{published}
META
end
