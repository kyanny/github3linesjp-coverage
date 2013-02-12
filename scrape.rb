#!/usr/bin/env ruby
# -*- coding: utf-8 -*-
require 'nokogiri'
require 'json'

entries = Dir['page*.html'].sort_by{ |page|
  page.match(/\d+/)[0].to_i     # 単に sort すると page9.html が page86.html より後ろに来てしまうので。
}.map{ |page|
  doc = Nokogiri::HTML(open(page))
  doc.search('.blog-post').map do |post|
    title     = post.search('.entry-title').first.text
    href      = post.search('.entry-title').first['href']
    published = post.search('.published').first['title']
    { title: title, href: href, published: published }
  end
}

open('entries.json', 'w'){ |f|
  f.puts JSON.pretty_generate(entries)
}
