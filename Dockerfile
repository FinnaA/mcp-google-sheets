# Используем минимальный Node.js образ
FROM node:18-alpine

# Устанавливаем рабочую директорию
WORKDIR /app

# Копируем только package*.json для установки зависимостей
COPY package*.json ./

# Устанавливаем зависимости
RUN npm install

# Копируем весь исходный код в контейнер
COPY . .

# Сборка TypeScript в JavaScript
RUN npm run build

# Открываем порт, если нужно (дополнительно, если сервер слушает порт)
EXPOSE 3000

# Запускаем сервер
CMD ["node", "dist/index.js"]
