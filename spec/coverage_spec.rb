# -*- coding: utf-8 -*-
require 'spec_helper'
require 'json'
require 'open-uri'

describe 'coverage' do
  @entries = JSON.parse(open('entries.json').read)
  @entries.each do |entry|
    permalink = entry['href'].sub(/\/blog/, '')
    title     = entry['title']
    published = entry['published'].sub(/-08:00/, '')

    headers = { "Accept-Language" => "ja,en;q=0.5" }

    it "#{permalink} が存在すること" do
      expect {
        open("http://github.kyanny.me#{permalink}", headers)
      }.to_not raise_error(OpenURI::HTTPError)
    end

    it "#{permalink} に出典が明記されていること" do
      begin
        expect(open("http://github.kyanny.me#{permalink}", headers).read).to match(/#{title}/)
      rescue OpenURI::HTTPError # 存在しない記事に対してはテストしない
        pending "#{permalink} はまだ書いていない"
      end
    end

    it "#{permalink} の公開日時が (見た目上) 一致していること" do
      begin
        time = Time.parse(published).strftime('%Y年%m月%d日 %H時%M分%S秒')
        expect(open("http://github.kyanny.me#{permalink}", headers).read).to match(/#{time}/)
      rescue OpenURI::HTTPError # 存在しない記事に対してはテストしない
        pending "#{permalink} はまだ書いていない"
      end
    end
  end
end
