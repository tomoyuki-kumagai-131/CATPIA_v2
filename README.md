# CATPIA

就職活動用に、ポートフォリオとして制作した自作WEBアプリケーションです。
<p>
お気に入りのねこカフェを共有し、コメントやいいねを送り合ってコミニュケーションを取ることが可能です。
制作背景につきましては下に記しました。
<p>
機能としてはシンプルですが、特にRSpecによるテスト(model,request・system)を重視していて、約140近くのexampleをパスしています。
<p>
また、UI/UXにも配慮し、使っていて楽しくなるようなWEBアプリを目指し、フロントエンドもこだわりを持って作成しました。
<p>
開発初期からDockerによる環境構築を行い、
開発途中からCircleCIを導入することで、自動テストを走らせて安全性を図るなど、モダンな技術を導入するようにしました。
AWS EC2にデプロイし、各種AWSサービスの利用・CD(自動デプロイ)機能も実装しました。
GitHubのIssues,Milestone機能,pull request等を利活用し、擬似チーム開発を取り入れて作成しました。
<p>
 
## URL
 
https://cat-pia.com/

* トップページのカルーセル内にかんたんログインボタンを配置しております。

<p>
 
## WEBページサンプル
 
<a href="https://gyazo.com/b9cfa592f5a81eb589817d8daf9044f6"><img src="https://i.gyazo.com/b9cfa592f5a81eb589817d8daf9044f6.jpg" alt="Image from Gyazo" width="400"/></a>

<a href="https://gyazo.com/32d86f26b46bd4f372990364e226c4b4"><img src="https://i.gyazo.com/32d86f26b46bd4f372990364e226c4b4.jpg" alt="Image from Gyazo" width="400"/></a>

<a href="https://gyazo.com/50b8946c3d2fede1ee823bc5f0626fba"><img src="https://i.gyazo.com/50b8946c3d2fede1ee823bc5f0626fba.jpg" alt="Image from Gyazo" width="400"/></a>

<a href="https://gyazo.com/8e9bdcb537207256852390d2967baa75"><img src="https://i.gyazo.com/8e9bdcb537207256852390d2967baa75.png" alt="Image from Gyazo" width="400"/></a>
 
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
 
## AWS構成図
 <a href="https://gyazo.com/5f32edf7415bcda21b0bd8156bf1e873"><img src="https://i.gyazo.com/5f32edf7415bcda21b0bd8156bf1e873.png" alt="Image from Gyazo" width="1461"/></a>
<p>
 
## 機能一覧
* ユーザー登録・ログイン機能
* ログイン保持機能(RememberMe)
* 投稿機能 （画像のアップロードにgem:CarrierWaveを使用）
* 投稿画像のリサイズ
* 投稿一覧・投稿詳細表示機能
* 投稿管理機能
* 投稿編集機能
* ページネーション機能（Kaminari）
* いいね機能（Ajax / 非同期処理）
* コメント機能（Ajax / 非同期処理）
* フォロー・フォロワー機能(Ajax / 非同期処理)
* 検索機能（gem:Ransackを使用）
* Rspec / Rubocop テスト機能
* CircleCI/CD 自動ビルド・自動テスト・自動デプロイ
* 通知機能(お気に入り登録・コメントがあった場合)
* モデルに対するバリデーション(文字数・メールアドレス・パスワードなど)

## 課題、今後実装したい機能
* クラウド整備
* 追加機能の実装(無限スクロール機能・パンくず機能など)
