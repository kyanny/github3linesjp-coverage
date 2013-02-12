#!/usr/bin/env ruby
# -*- coding: utf-8 -*-

Dir.mkdir('tmp') unless Dir.exists?('tmp')
page = (1..86)                  # ページ増えたら変更する
base_url = 'https://github.com/blog?page=%d'
page.each do |i|
  `wget #{base_url % i} -O ./tmp/page#{i}.html`
end
