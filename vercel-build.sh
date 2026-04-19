#!/bin/bash

echo "🚀 开始下载 Linux 版 Pandoc..."
curl -L https://github.com/jgm/pandoc/releases/download/3.1.1/pandoc-3.1.1-linux-amd64.tar.gz | tar xz

echo "🔗 将 Pandoc 注入 Vercel 环境变量..."
export PATH=$PWD/pandoc-3.1.1/bin:$PATH

echo "✅ Pandoc 安装完毕，版本信息如下："
pandoc -v

echo "🕵️ 动态注入 Algolia 密钥到配置文件..."
if [ -z "$ALGOLIA_ADMIN_API_KEY" ]; then
  echo "❌ 警告：Vercel 环境变量中没有找到 ALGOLIA_ADMIN_API_KEY，注入失败！请检查 Vercel 后台！"
else
  sed -i "s/VERCEL_ALGOLIA_KEY/$ALGOLIA_ADMIN_API_KEY/g" _config.yml
  echo "✅ 密钥动态注入成功！"
fi

echo "🔨 开始生成 Hexo 博客静态文件..."
hexo g

echo "🔍 开始自动向云端推送 Algolia 搜索索引..."
hexo algolia