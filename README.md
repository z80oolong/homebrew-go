# z80oolong/go -- Go 言語処理系を導入するための Formula 群

## 概要

[Linuxbrew][BREW] とは、Linux の各ディストリビューションにおけるソースコードの取得及びビルドに基づいたパッケージ管理システムです。 [Linuxbrew][BREW] の使用により、ソースコードからのビルドに基づいたソフトウェアの導入を単純かつ容易に行うことが出来ます。                                          

この [Linuxbrew][BREW] 向け Tap リポジトリは、公式の [Go 言語処理系][GO__]を導入するための Formula 群を含む Tap リポジトリです。

オリジナルの Formula である ```homebrew/core/go``` と異なり、 [64 bit x86 CPU アーキテクチャ][X86P]搭載の [Linux 系 OS][LNUX] や [Mac OS][MAC_] の他、 [32 bit ARM CPU アーキテクチャ][ARMP]及び [32 bit x86 CPU アーキテクチャ][X86P]搭載の [Linux 系 OS][LNUX] への [Go 言語処理系][GO__]の導入にも対応しています。

また、 [Go 言語処理系][GO__]をビルドするための bootstrap 用の [Go 言語処理系][GO__]を導入するための Formula を独立させ、オリジナルの ```homebrew/core/go``` において行われていた bootstrap 用の [Go 言語処理系][GO__]の展開及び削除処理を省力化しました。

## 使用法

まず最初に、以下に示す Qiita の投稿及び Web ページの記述に基づいて、手元の端末に [Linuxbrew][BREW] を構築し、以下のように  ```brew tap``` コマンドを用いて本リポジトリを導入します。

- [thermes 氏][THER]による "[Linuxbrew のススメ][THBR]" の投稿
- [Linuxbrew の公式ページ][BREW]

そして、本リポジトリに含まれる Formula を以下のようにインストールします。

```
 $ brew tap z80oolong/go
 $ brew install <formula>
```

なお、一時的な手法ですが、以下のようにして URL を直接指定してインストールすることも出来ます。

```
 $ brew install https://raw.githubusercontent.com/z80oolong/homebrew-go/master/Formula/<formula>.rb
```

なお、本リポジトリに含まれる Formula の一覧及びその詳細については、本リポジトリに同梱する ```FormulaList.md``` を参照して下さい。

## その他詳細について

その他、本リポジトリ及び [Linuxbrew][BREW] の使用についての詳細は ```brew help``` コマンド及び  ```man brew``` コマンドの内容、若しくは [Linuxbrew の公式ページ][BREW]を御覧下さい。

## 謝辞

まず最初に、 [Robert C. Pike 氏][PIKE]を始めとする [Go 言語処理系][GO__]の開発コミュニティの各氏に心より感謝致します。

そして、[Linuxbrew][BREW] の導入に関しては、 [Linuxbrew の公式ページ][BREW] の他、 [thermes 氏][THER]による "[Linuxbrew のススメ][THBR]" 及び [Linuxbrew][BREW] 関連の各種資料を参考にしました。 [Linuxbrew の開発コミュニティ][BREW]及び[thermes 氏][THER]を始めとする各氏に心より感謝致します。

そして最後に、 [Go 言語処理系及び Go 言語][GO__]に関わる全ての皆様及び、 [Linuxbrew][BREW] に関わる全ての皆様に心より感謝致します。

## 使用条件

本リポジトリは、 [Linuxbrew][BREW] の Tap リポジトリの一つとして、 [Linuxbrew の開発コミュニティ][BREW]及び [Z.OOL. (mailto:zool@zool.jpn.org)][ZOOL] が著作権を有し、[Linuxbrew][BREW] のライセンスと同様である [BSD 2-Clause License][BSD2] に基づいて配布されるものとします。詳細については、本リポジトリに同梱する ```LICENSE``` を参照して下さい。

<!-- 外部リンク一覧 -->

[BREW]:https://linuxbrew.sh/
[GO__]:https://golang.org/
[ARMP]:https://www.arm.com/
[X86P]:https://www.intel.co.jp/content/www/jp/ja/homepage.html
[LNUX]:https://www.kernel.org/
[MAC_]:https://www.apple.com/jp/macos/mojave/
[PIKE]:http://herpolhode.com/rob/
[THER]:https://qiita.com/thermes
[THBR]:https://qiita.com/thermes/items/926b478ff6e3758ecfea
[BSD2]:https://opensource.org/licenses/BSD-2-Clause
[ZOOL]:http://zool.jpn.org/
