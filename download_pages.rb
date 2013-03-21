#!/usr/bin/env ruby
# -*- coding: utf-8 -*-
#
# GitHub Blog から全エントリ (インデックスページ) の HTML をダウンロードする
require 'nokogiri'

# HTML 置き場
Dir.mkdir('tmp') unless Dir.exists?('tmp')

# ページングのリンクから一番古いページ番号を得る
`wget https://github.com/blog -O ./tmp/latest.html`
doc = Nokogiri::HTML(open('./tmp/latest.html'))
oldest_page = doc.search('.pagination a').sort_by{ |anchor|
  anchor['href'].match(/page=(\d+)/)[1].to_i # /blog?page=86 とかの 86 でソート
}.last['href'].match(/page=(\d+)/)[1].to_i   # 一番最後のページの番号 86 を得る

base_url = 'https://github.com/blog?page=%d'
(1..oldest_page).each do |i|
  `wget #{base_url % i} -O ./tmp/page#{i}.html`
end
