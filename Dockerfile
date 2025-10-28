# Этап сборки
FROM node:20-alpine AS builder

WORKDIR /app

# Копируем package.json и package-lock.json для установки зависимостей
COPY package*.json ./

# Устанавливаем зависимости
RUN npm install

# Копируем остальной код проекта
COPY . .

# Собираем TypeScript-проект
RUN npm run build

# Этап выполнения (для продакшена)
FROM node:20-alpine

WORKDIR /app

# Копируем только необходимые файлы из этапа сборки:
# - node_modules для запуска
# - Скомпилированный JavaScript-код (папка dist)
# - package.json (необходим для npm start)
COPY --from=builder /app/node_modules ./node_modules
COPY --from=builder /app/dist ./dist
COPY --from=builder /app/package*.json ./

# Если ваш MCP сервер слушает определенный порт, его следует здесь открыть.
# Например, если ваш сервер слушает порт 3000:
EXPOSE 3000

# Команда для запуска вашего MCP сервера
CMD ["npm", "start"]
