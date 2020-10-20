# CATPIA

「CATPIA」は、個人開発アプリケーションとして完全独学で制作した自作WEBアプリケーションです。
<p>
お気に入りの猫カフェを共有し、コメントやいいねを送り合ってコミニュケーションを取ることが可能です。
制作背景につきましては下に記しました。
<p>
Google Maps Apiを導入して投稿した住所情報から店舗地図の表示、通知機能の導入により、
いいね！やコメントがあった際に左上のベルマークに通知を表示させる等、ストレスフリーな使用感を目指しました。
RSpecによるテスト(model・request・system)は約140近くのexampleをパスしました。
<p>
また、UI/UXにも配慮し、使っていて楽しくなるようなWEBアプリを目指し、フロントエンドにもこだわりを持って作成しました。
<p>
インフラについては
AWS(RDS,S3,Route53,ACM,ALB,IAM等)や保守性を高める為にCircleCI、実行環境をDockerfileにより共有でき、環境構築を容易にするDockerなどのモダンな技術にチャレンジし、実務に入ったときにも通用する技術を意識して習得するようにしました。

<p>
AWS EC2にデプロイし、各種AWSサービスの利用・CD(自動デプロイ)機能も実装し、「git push」コマンドのみでテストから自動デプロイまで行える形にしました。
<p>
GitHubのIssues,Milestone機能,pull request等を利活用し、擬似チーム開発を取り入れて作成しました。
<p>
【新機能】
・いいね！が多い投稿をランキング形式で表示するページを設置。

## URL

https://cat-pia.com/

* 常時SSL化 (AWS ACM, Route53, ALB)
* トップページのカルーセル内にかんたんログインボタンを配置しております。

<p>

## AWS構成図
<a href="https://gyazo.com/fa75180a75bcc2812c07f67d2fbf1fa0"><img src="https://i.gyazo.com/fa75180a75bcc2812c07f67d2fbf1fa0.png" alt="Image from Gyazo" width="1528"/></a>

<p>

## WEBページサンプル

<a href="https://gyazo.com/06f5133bb16fcd7aa05d3106871d0e32"><img src="https://i.gyazo.com/06f5133bb16fcd7aa05d3106871d0e32.jpg" alt="Image from Gyazo" width="400"/></a>

<a href="https://gyazo.com/d389ceba6492662781f158363593c1f2"><img src="https://i.gyazo.com/d389ceba6492662781f158363593c1f2.jpg" alt="Image from Gyazo" width="400"/></a>

<a href="https://gyazo.com/86f851bdd1fdeee933f4fc0efb134acb"><img src="https://i.gyazo.com/86f851bdd1fdeee933f4fc0efb134acb.jpg" alt="Image from Gyazo" width="400"/></a>

<a href="https://gyazo.com/718dca5c4969e51ea40c2803d6d657e1"><img src="https://i.gyazo.com/718dca5c4969e51ea40c2803d6d657e1.jpg" alt="Image from Gyazo" width="400"/></a>

## 制作背景
<p>
私は6歳になる黒猫を一匹飼っているのですが、生まれて２〜３ヶ月という幼い頃に、
<p>
雨の中道で鳴いていたところを拾い、動物病院に連れていき、飼い始めたという経緯があります。
<p>
ポートフォリオを作り始めたのが２０２０年5月中旬で、コロナウィルス蔓延の真っ只中でした。
<p>
「おうち時間」が増える中で、ペット需要、中でも散歩の必要がない猫が人気だとニュースで見ました。
<p>
しかし、飼育放棄や多頭飼育による環境崩壊などの問題もこれから更に増えてくると思います。
<p>
気軽にペットを飼い始めると、飼えなくなった時に路上に放棄するといった方が少なからずいます。
<p>
まずは気軽に猫カフェに足を運んでいただいて、猫の魅力に気付いてもらいたいと思いました。
<p>
猫カフェはただ猫と戯れることができるカフェ、と思われている方も多いかもしれないですが、
<p>
実際は保護猫がお店にいて、引き取りや譲渡会も行っている、という形態を取っている猫カフェも多いです。
<p>
いきなり猫を飼い始めるのではなく、猫カフェで猫を知っていただいた後に飼育して欲しい、という思いもあり、
<p>
フランクにお気に入りの猫カフェを投稿したり閲覧できるWEBアプリを作ろうと思いました。
<p>
お気に入りの猫カフェとして紹介することで、売り上げの貢献、結果的に保護猫の引き取り手が増えるのではないか、という想いもあります。
<p>
長くなってしまいましたが、このWEBアプリのコンセプトを纏めますと以下のポイントになります。

* 猫の魅力の再発見
* 保護猫の良質な引き取り手を増加させる
* 猫カフェへの売り上げの貢献
* SNS口コミ奨励し、アクセスを増加させる
* アクセスによる広告収入等の収益を得る仕組み作り(実際にサービスとして展開した場合)

## 使用技術
* HTML
* CSS
* Javascript / JQuery / Ajax
* Ruby 2.5.3 / Slim記法
* Ruby on Rails 5.2.4 (RSpec / Rubocopによる動的静的テスト等も含む)
* MySQL
* Linux (各種コマンド操作)
* Nginx (Web Server)
* Puma (Application Server)
* Git / GitHub (pull request, Issues 等による擬似チーム開発)
* Docker / docker-compose
* AWS各種サービス
* CircleCI/CD
* Capistrano
* AWS
<br>  EC2 ( Amazon Linux 2 ) / RDS(MySQL) / S3 / VPC / IAM / Route53 / ACM / ALB
<p>

## 機能一覧
* ユーザー登録・ログイン機能
* ログイン保持機能(RememberMe)
* 投稿機能 （画像のアップロードにgem:CarrierWaveを使用）
* 投稿画像のリサイズ
* 投稿一覧・投稿詳細表示機能
* 投稿管理機能
* 投稿編集機能
* 右下のねこイラストから新規投稿が可能(自作のイラストです)
* ページネーション機能（gem: Kaminari）
* Flash機能(gem: toastr)
* いいね機能（Ajax / 非同期処理）
* コメント機能（Ajax / 非同期処理）
* フォロー・フォロワー機能 (Ajax / 非同期処理)
* Google Maps 地図表示機能 (Google Maps API利用)
* 検索機能（gem: Ransackを使用）
* Rspec / Rubocop テスト機能
* CircleCI/CD 自動ビルド・自動テスト・自動デプロイ
* 通知機能 (お気に入り登録・コメントがあった場合、左上のベルマークに通知表示)
* 通知一覧表示機能
* お気に入り登録が多い猫カフェをランキング形式で表示する機能
* モデルに対する複数バリデーション(文字数・メールアドレス・パスワードなど)

## 課題、今後実装したい機能
* より使いやすいアプリケーションを目指し、UI/UXを改善する
* 新機能の実装
