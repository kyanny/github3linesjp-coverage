require 'spec_helper'
require 'json'
require 'net/http'

describe 'coverage' do
  @entries = JSON.parse(open('entries.json').read)
  @entries.each do |entry|
    permalink = entry['href'].sub(/\/blog/, '')
    it "#{permalink} exists" do
      Net::HTTP.start('github.kyanny.me', 80){ |http|
        res = http.head(permalink)
        expect(res).to be_a_kind_of(Net::HTTPSuccess)
      }
    end
  end
end
