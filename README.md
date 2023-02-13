# Hello PyPI

## 利用確認

```
$ python --version
```
3.6以上 ... see setup.py

```
$ pip --version
```
pip利用可能であること

```
$ wheel -h
```
ビルドした後のパッケージ化に利用

```
$ pip show setuptools
```
setuptoolsを利用している

```
$ jf --version
```
JFrog CLIが入っている https://jfrog.com/ja/getcli/


## Development Flow with JFrog

### リポジトリ作成後のCLI設定
```
$ jf c add
$ jf c show
$ jf c use $SERVER_ID
```

### pipの設定
```
$ jf pipc
```

### 依存関係のインストール
```
$ jf pip install -r requirements.txt --build-name=hello-pypi-build --build-number=1 --no-cache-dir --force-reinstall
```

### ビルド
```
$ python setup.py sdist bdist_wheel
$ PYTHONPATH=build/lib python -m hello
```

### Artifactoryに登録
```
$ jf rt u dist/ $TARGET_REPO --build-name=sample-pypi-build --build-number=1
```

### Build Infoの収集と登録 - ビルドの登録
```
$ jf rt bce sample-pypi-build 1
$ jf rt bag sample-pypi-build 1
$ jf rt bp sample-pypi-build 1
```

### 登録したものをインストール/テスト
```
$ jf pip install jfrogsample-hello
$ pip show jfrogsample-hello
$ python -m hello
```


# Hello Docker

## 利用確認

```
$ docker --version
```
Docker Desktopが入っている

```
$ jf --version
```
JFrog CLIが入っている https://jfrog.com/ja/getcli/

## Development Flow with JFrog

### リポジトリ作成後のCLI設定
```
$ jf c add
$ jf c show
$ jf c use $SERVER_ID
```

### Artifactoryにログイン
```
$ docker login $INSTANCE.jfrog.io/$DOCKER_REGISTRY/
```

### Docker pull
```
$ jf docker pull python:$PYTHON_VERSION-slim
```

### Docker ビルド
```
$ docker build \
    --build-arg JFROG_USER=$USER \
    --build-arg JFROG_TOKEN=$TOKEN \
    --build-arg JFROG_INSTANCE=$INSTANCE \
    -t $INSTANCE.jfrog.io/$DOCKER_REGISTRY/app:latest .
```

### Docker push
```
$ jf docker push $INSTANCE.jfrog.io/$DOCKER_REGISTRY/app:latest --build-name=sample-docker-build --build-number=1

```

### Build Infoの登録 - ビルドの登録
```
jf rt bp sample-docker-build 1
```
