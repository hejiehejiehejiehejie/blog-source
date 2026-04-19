#!/bin/bash

echo "🚀 开始下载 Linux 版 Pandoc..."
curl -L https://github.com/jgm/pandoc/releases/download/3.1.1/pandoc-3.1.1-linux-amd64.tar.gz | tar xz

echo "🔗 将 Pandoc 注入 Vercel 环境变量..."
export PATH=$PWD/pandoc-3.1.1/bin:$PATH

echo "✅ Pandoc 安装完毕，版本信息如下："
pandoc -v

echo "🔨 开始生成 Hexo 博客静态文件..."
hexo g

echo "🕵️ 开始检测 Algolia 环境变量..."
if [ -z "$HEXO_ALGOLIA_INDEXING_KEY" ]; then
  echo "❌ 完蛋，Vercel 还是没有把 HEXO_ALGOLIA_INDEXING_KEY 交给脚本！请检查 Vercel 设置。"
else
  echo "✅ 成功拿到 Algolia 密钥，准备起飞！"
fi

echo "🔍 开始自动向云端推送 Algolia 搜索索引..."
hexo algolia