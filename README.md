# Docker for rails test on bitbucket

ruby, mysql, imagemagick

# 使い方
```
$ docker pull keip/rails-test
```

[Docker Hub - keip/rails-test](https://hub.docker.com/r/keip/rails-test/)

# 開発環境の構築
```
$ docker-machine create --driver virtualbox dev
$ docker-machine start dev
$ docker-machine env dev
$ eval $(docker-machine env dev)
```

## 開発
```
$ docker build -t kei-p/rails-test ./
$ docker run -i --rm -t kei-p/rails-test /bin/bash
```

## 参考
[docker-machine の使い方](http://qiita.com/spesnova/items/038af6a8a4e401e3d2aa)
