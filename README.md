# README

###users
| カラム | データ型 |
| -------- | -------- |
| name | string |
| email | string |
| password_digest | string |

###tasks
| カラム | データ型|
| -------- | -------- |
| user_id | |
| title | string |
| content | text |
| deadline | data |
| priority |　integer |
| status | integer |

###labels
| カラム | データ型 |
| -------- | -------- |
| name    | string     |

###herokuのデプロイ手順
1. herokuへログイン
* heroku login
3. herokuアプリ作成
* heroku create
5. Gemインストール
* gem 'net-smtp'
* gem 'net-imap'
* gem 'net-pop'
4. step2ブランチをherokuにプッシュする
* git push heroku step2:master
6. herokuのテーブル作成
* heroku run rails db:migrate