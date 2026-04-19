module.exports = {
  globPatterns: ["404.html", "css/index.css"], // 基础缓存文件
  globDirectory: "public",
  swDest: "public/service-worker.js",
  maximumFileSizeToCacheInBytes: 10485760, // 缓存文件的最大限制
  skipWaiting: true,
  clientsClaim: true,
  runtimeCaching: [
    {
      urlPattern: /^https:\/\/npm\.elemecdn\.com\/anzhiyu-blog/, // 缓存 CDN 资源
      handler: "CacheFirst",
    },
  ]
};