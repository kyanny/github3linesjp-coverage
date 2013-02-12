# カバレッジ

## GitHub Blog の全エントリの URL を得るために HTML をダウンロードして集める

    $ ruby ./download_pages.rb

## 集めた HTML から permalink と title をスクレイピングして抜き出す

    $ ruby ./scrape.rb
    
## 最新のページの HTML だけダウンロードする

    $ rake download_latest_page
    
## entries.json をアップデートする

(entries.json は spec/coverage_spec.rb のテストケースのもとになるファイル)

    $ rake update_entries

## テストを実行する

    $ rake
    $ rake do_spec
    
## テストを実行する (entries.json アップデートなし)

    $ rake spec
