#!/usr/bin/env ruby
# -*- coding: utf-8 -*-
#
# GitHub Blog から一番新しいインデックスページの HTML をダウンロードする
require 'nokogiri'

# HTML 置き場
Dir.mkdir('tmp') unless Dir.exists?('tmp')

`wget https://github.com/blog -O ./tmp/latest.html`
