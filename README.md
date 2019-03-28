# JCasC's sample
- - -
## 事前用意ファイル
- `/var/deploy/secrets/adminUser`
- `/var/deploy/secrets/adminpw`

jenkinログイン用　アドミンユーザー名、パスワードをそれぞれ用意しておきます。

- - -
## 実行コマンド
```
docker-compose up --build
```

永続化する場合は以下
```
docker-compose up --build -d
```

dockerイメージのダウンロード後、
プラグインダウンロード、インストール、jenkinsの構築、設定を経て、
jenkinsプロジェクトを起動します。

- - -
## jenkinsアクセス
自機のブラウザから、`locahost:80`でアクセス出来ます。
ログインは`事前用意ファイル`で設定した内容で可能です。

※二回目以降実行時は、後述の`その他コマンド`も参考のこと。

- - -
## 調整対象ファイル
1. `./master/Dockerfile` 
2. `./master/plugin_extra.txt`
3. `./docker-compose.yml`
4. `./jenkins.yaml`

### 1. `./master/Dockerfile`
元となるjenkinsイメージの指定、環境変数の定義や、jenkinsプラグイン適用の為の処理を記述しています。


### 2. `./master/plugin_extra.txt`
適用されるjenkinsプラグインの一覧を記述しています。

※ jenkins側にもこの機能はあるが、今のところ動作が安定しておらず、一旦は課題とし、今今はDocker側でインストールすることとする。


### 3. `./docker-compose.yml`
`docker-compose` コマンド実行時の構成を管理します。利用ポート、事前用意ファイルのパス、dockerのvolume設定等。


### 4. `./jenkins.yaml`
JCasCのメインファイルになります。こちらに記載された内容を読み込むことで、各種設定やジョブの自動構築が行われます。

今回のサンプルの様に、dockerと絡めて１ステップで新規構築する方法の他、既存のjenkins(jcascプラグイン適用済)に展開することも可能です。

- - - 
## その他コマンド

初回以降、実行ケースによって実施前の準備が異なるので、関連するコマンドは列記します。


### 1.Dockerコンテナ　ステータス確認
```
docker ps -a
```


### 2.Dockerコンテナ　停止
```
docker stop {コンテナID}
```


### 3.Dockerボリューム　一覧確認
```
docker volume ls
```


### 4.Dockerボリューム　削除
```
docker volume rm {イメージID}
```


### 5.不要イメージ/コンテナ一括削除
```
docker system prune
```


### 6.Dockerイメージ　一覧確認
```
docker image ls
```


### 7.Dockerイメージ　削除
```
docker image rm {ボリュームID}
```


#### jenkins.yamlを修正したので、jenkinsに反映したい。
- `実行コマンド`を再度実行します。


#### dockerボリュームを削除して、もう一度jenkinsを再構築し直したい。
1. `1.Dockerコンテナ　ステータス確認`
2. `2.Dockerコンテナ　停止`
3. `3.Dockerボリューム　一覧確認`
4. `4.Dockerボリューム　削除` (上手くいかない場合、先に`5.不要イメージ/コンテナ一括削除`)

`実行コマンド`を再度実行します。


#### dockerイメージのダウンロードからやり直す場合。
上記に加えて、下記を実施します。
- `6.Dockerイメージ　一覧確認`
- `7.Dockerイメージ　削除`

`実行コマンド`を再度実行します。

- - - 
## コード化後　可能なこと

### ユーザ
- アドミンユーザ自動登録
- 任意のユーザ自動登録

### プラグイン
- 自動インストール(docker利用)
　
### ジョブ
- ソースの外出し

(通常ジョブ)
- 定期実行
- 完了後、失敗後のslack通知

(pipelineジョブ)
- 定期実行
- pipelineソースのgithub(public)からの取得
- pipelineから別のpipelineジョブの呼び出し 

- - -
## Jenkins コード化後出来ていないこと

### ユーザ
- 詳細情報の設定（メールアドレス等）

### プラグイン
- 自動インストール(jenkinsファイル利用)

### ジョブ
- リモート起動
- githubのpushトリガー連携

- - -
## Notice !
This source is based on JCasC's sample.

[https://github.com/Praqma/praqma-jenkins-casc](https://github.com/Praqma/praqma-jenkins-casc)

[https://www.kaizenprogrammer.com/entry/2018/09/23/030646](https://www.kaizenprogrammer.com/entry/2018/09/23/030646)
