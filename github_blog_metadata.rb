#!/usr/bin/env ruby
# -*- coding: utf-8 -*-
require 'open-uri'
require 'nokogiri'

url = ARGV.shift
doc = Nokogiri::HTML(open(url))
title = doc.search('title').text
doc.search('.blog-post').map do |post|
  href      = post.search('.entry-title').first['href']
  published = post.search('.published').first['title']
  puts <<META
#{href.sub(/\/blog\//, '')}

出典: [#{title}](https://github.com#{href})

#{published}
META
end
