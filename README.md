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
