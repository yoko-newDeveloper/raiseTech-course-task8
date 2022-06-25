# 概要
DockerによるMySQLの構築を初めて行うひとのためのガイドプロジェクトです。

# ハンズオン

## 前提

GitやUNIXコマンドの操作についてはすでに学習済みを想定しています。

## お願い
- もし手順にあやまりがあればぜひ教えて下さい!
- 各コマンド実施時に表示されるメッセージはよく読みましょう!
  - 問題が起きていることに気づかずどんどんコマンド実行して気づいたらめちゃくちゃに・・・というのはあるあるです。

## Dockerの準備

Dockerをインストールする。  
確認方法はターミナルから下記を実行する。  

```bash
% docker -v
Docker version 20.10.12, build e91ed5707e
```

## 手順

レポジトリを任意のディレクトリ配下にてcloneします。  

cloneしたらディレクトリ内に移動して作業を始めましょう。  

docker-compose.ymlがあることを確認する。  
```bash
% ls
Dockerfile              conf                    renovate.json
README.md               docker-compose.yml      sql
```

コンテナを起動する。  
ただし初回は時間がかかります。  
出力内容も下記より多いです。  
```bash
% docker compose up -d
[+] Running 2/2
 ⠿ Network docker-mysql-hands-on_default  Created                                                                                  0.0s
 ⠿ Container docker-mysql-hands-on        Started
```

コンテナを確認します。  
docker-mysql-hands-onがあればOKです。  
```bash
% docker ps           
CONTAINER ID   IMAGE                      COMMAND                  CREATED          STATUS          PORTS                               NAMES
850fd542e459   docker-mysql-hands-on_db   "docker-entrypoint.s…"   45 seconds ago   Up 45 seconds   33060/tcp, 0.0.0.0:3307->3306/tcp   docker-mysql-hands-on
```

MySQLにログインします。
パスワードはdocker-compose.ymlに記載されているとおり「password」です。

```bash
% docker compose exec db mysql -uroot -p    
Enter password:
```

以下のように表示されればMySQLにログインできています。  

```bash
% docker compose exec db mysql -uroot -p    
Enter password: 
Welcome to the MySQL monitor.  Commands end with ; or \g.
Your MySQL connection id is 8
Server version: 8.0.29 MySQL Community Server - GPL

Copyright (c) 2000, 2022, Oracle and/or its affiliates.

Oracle is a registered trademark of Oracle Corporation and/or its
affiliates. Other names may be trademarks of their respective
owners.

Type 'help;' or '\h' for help. Type '\c' to clear the current input statement.

mysql>
```

movie_listがあることを確認する。  
以下の場合、`show databases;`と打ち込んでください。  
SQL文においてセミコロンはコマンドの終わりを意味していますので入力忘れがないようにしましょう。  

```mysql
mysql> show databases;
+--------------------+
| Database           |
+--------------------+
| information_schema |
| movie_list         |
| mysql              |
| performance_schema |
| sys                |
+--------------------+
5 rows in set (0.03 sec)
```

movie_listの利用を開始する。  

```mysql
mysql> use movie_list;
Reading table information for completion of table and column names
You can turn off this feature to get a quicker startup with -A

Database changed
```

moviesテーブルがあることを確認する。

```mysql
mysql> show tables;
+----------------------+
| Tables_in_movie_list |
+----------------------+
| movies               |
+----------------------+
1 row in set (0.02 sec)
```

moviesテーブルのレコードを確認する。

```mysql
mysql> select * from movies;
+----+--------------------------------+-----------------------------+
| id | name                           | director                    |
+----+--------------------------------+-----------------------------+
|  1 | ショーシャンクの空に           | フランク・ダラボン          |
|  2 | この世界の片隅に               | 片渕須直                    |
+----+--------------------------------+-----------------------------+
2 rows in set (0.00 sec)
```

テーブルにレコードを追加してみる。

```mysql
mysql> insert into movies (name, director) values ("ゴッドファーザー", "フランシス・フォード・コッポラ");
Query OK, 1 row affected (0.03 sec)
```

レコードの登録結果を確認する。

```mysql
mysql> select * from movies;
+----+--------------------------------+-----------------------------------------------+
| id | name                           | director                                      |
+----+--------------------------------+-----------------------------------------------+
|  1 | ショーシャンクの空に           | フランク・ダラボン                            |
|  2 | この世界の片隅に               | 片渕須直                                      |
|  3 | ゴッドファーザー               | フランシス・フォード・コッポラ                |
+----+--------------------------------+-----------------------------------------------+
3 rows in set (0.01 sec)
```

ログアウトする。  
```mysql
mysql> exit
Bye
```

起動したDockerコンテナを停止する。  

```bash
$ docker compose down
```

停止できていることを確認する。  
```bash
% docker ps
CONTAINER ID   IMAGE     COMMAND   CREATED   STATUS    PORTS     NAMES
```

ここまでできたらハンズオン完了です！  
お疲れさまでした！  
