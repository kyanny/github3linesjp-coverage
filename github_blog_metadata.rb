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

  entry_content = post.search('.entry-content').first
  images = entry_content.search('img').map{ |img|
    img['src']
  } || []
  images.reject!{ |img| img.match(%r!/images/icons/emoji/!) }
  images = images.map{ |img| "![図](#{img})"}.join("\n")

  puts <<META
#{href.sub(/\/blog\//, '')}

#{images}

出典: [#{title}](https://github.com#{href})

#{published}
META
end
