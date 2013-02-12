#!/usr/bin/env ruby
# -*- coding: utf-8 -*-

page = (1..86)                  # ページ増えたら変更する
base_url = 'https://github.com/blog?page=%d'
page.each do |i|
  `wget #{base_url % i} -O page#{i}.html`
end
