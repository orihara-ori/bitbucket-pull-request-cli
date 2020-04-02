# はじめに
- bitbucket api を利用して、特定の branch への Pull Request 一覧を取得するコマンドラインツールです。
- 比較的多くの人に簡単に利用してもらうために mac のデフォルトの ruby で gem を利用しなくても動作することを念頭に置いています。

# 使い方
## 準備
- コードをローカルに git clone
```
git clone https://github.com/orihara-ori/bitbucket-pull-request-cli.git
cd bitbucket-pull-request-cli/
```

- basic 認証で利用する認証情報を取得
  - app passwordでハッシュ値を作る
    - https://ja.confluence.atlassian.com/bitbucket/app-passwords-828781300.html
```
$ echo -n YOUR-ATLASSIAN-USER-NAME:YOUR-ATLASSIAN-APP-PASSWORD | base64
WU9VUi1BVExBU1NJQU4tVVNFUi1OQU1FOllPVVItQVRMQVNTSUFOLUFQUC1QQVNTV09SRA==
```


## コマンド実行
- フォーマット
```
ruby pull_requests.rb BASE64-OUTH-INFO YOUR-TEAM/YOUR-REPOSITORY YOUR-DESTINATION-BRANCH
```

- 例
  - 401 が返りますが `WU9VUi1BVExBU1NJQU4tVVNFUi1OQU1FOllPVVItQVRMQVNTSUFOLUFQUC1QQVNTV09SRA==` を正しく設定すると利用できます
```
ruby pull_requests.rb WU9VUi1BVExBU1NJQU4tVVNFUi1OQU1FOllPVVItQVRMQVNTSUFOLUFQUC1QQVNTV09SRA== orihara-ori/example master
```
