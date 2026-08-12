FROM node:22-alpine

# 安装 better-sqlite3 编译依赖（gcc + make + python）
RUN apk add --no-cache gcc g++ make python3

WORKDIR /app

# 先复制依赖定义文件，利用 Docker 缓存层
COPY package.json ./

RUN npm install

# 复制其余源码
COPY . .

# 构建前端
RUN npm run build

# 暴露端口（Railway 会自动注入 PORT 环境变量）
EXPOSE 3001

# 启动命令：Express 同时托管前端静态文件 + API
CMD ["node", "server/index.js"]
