# 🚀 ПОЛНЫЙ ГАЙД ПУБЛИКАЦИИ HOLLOW: HORROR

## Этап 1️⃣: Подготовка репозитория (5 минут)

### На GitHub

1. **Создай новый репо**
   - Зайди https://github.com/new
   - Назови: `hollow-horror`
   - Выбери Public (чтобы все видели)
   - Создай

2. **Клонируй к себе**
   ```bash
   git clone https://github.com/твой-юзер/hollow-horror.git
   cd hollow-horror
   ```

3. **Скопируй все файлы проекта в папку**
   - Скопируй `project.godot`, `export_presets.cfg` и папки `scripts/`, `scenes/` итд
   - Создай `.gitignore`

4. **Загрузи на GitHub**
   ```bash
   git add .
   git commit -m "Initial horror game project"
   git push origin main
   ```

## Этап 2️⃣: Настройка GitHub Actions (5 минут)

1. **Проверь файл workflow**
   - Должен быть: `.github/workflows/build-apk.yml`
   - Он там уже создан!

2. **Включи Actions**
   - Settings → Actions → General
   - Выбери "Allow all actions and reusable workflows"
   - Save

3. **Проверь что все работает**
   - Push любое изменение: `git push`
   - Жди 15 минут
   - Зайди на вкладку Actions
   - Должен быть зеленый чекпойнт ✅

## Этап 3️⃣: Скачивание APK (5 минут)

1. **Зайди в GitHub репо**
2. **Вкладка Actions**
3. **Выбери последний workflow**
4. **Внизу Artifacts**
5. **Скачай `hollow-horror-apk`**
6. Распакуй - там твой `hollow.apk` 🎮

## Этап 4️⃣: Тестирование на телефоне

### Способ A: Через Google Play Services (если есть)
```bash
adb install hollow.apk
```

### Способ B: Копирование файла
1. Переправь `hollow.apk` на телефон через USB
2. Открой Files → найди hollow.apk
3. Тап → Install

## Этап 5️⃣: Публикация на itch.io (10 минут) ⭐ САМЫЙ ЛЁГКИЙ СПОСОБ

### Лучшая платформа для инди-игр!

1. **Создай аккаунт**
   - https://itch.io
   - Dashboard

2. **Create new project**
   - Title: `Hollow Horror`
   - Description: "Криповый 3D хоррор на Godot. Убегай от монстров и используй оружие!"
   - Release date: сегодня

3. **Загрузи игру**
   - Click upload files
   - Выбери `hollow.apk`
   - Classmate as "Application"
   - Platform: **Android**
   - Mark as "Installable"

4. **Публикуй!**
   - Save & Publish
   - **ГОТОВО!** Твоя игра доступна миру

5. **Ссылка на игру:**
   ```
   https://твой-юзер.itch.io/hollow-horror
   ```

## Этап 6️⃣: Публикация на Google Play (30 минут) 💰

### Требует деньги, но доходит до миллионов

1. **Создай Google Play Developer аккаунт**
   - https://play.google.com/console
   - Нужна кредитка ($25 один раз)

2. **Создай подписанный APK**
   - В Godot: File → Project Settings → Export
   - Нужен keystore (создаст ключ один раз)
   - Нажми Export и выбери место

3. **Create new app**
   - App name: Hollow Horror
   - Type: Games
   - Заполни все поля

4. **Upload APK**
   - Release → Production
   - Upload signed APK

5. **Заполни информацию**
   - Описание игры
   - Скриншоты (минимум 2)
   - Иконка
   - Жанр: Games

6. **Submit**
   - Жди 24-48 часов на модерацию
   - Если одобрили - **ГОТОВО!**

## Этап 7️⃣: Маркетинг (бесплатно)

1. **Поделись в соцсетях**
   - Twitter: Пост о игре с ссылкой
   - TikTok: 15-30 сек видео из игры
   - Reddit: r/GameDev, r/AndroidGaming
   - Discord: игровые серверы

2. **Пример поста:**
   ```
   🎮 Релиз! Hollow: Horror - криповый 3D хоррор на мобильник
   🔥 AI враги, система боя, страшная атмосфера
   📥 Скачай бесплатно на itch.io
   https://твой-юзер.itch.io/hollow-horror
   #IndieGame #HorrorGame #Godot
   ```

## 🎯 Чек-лист

### До публикации:
- [ ] Игра работает на телефоне
- [ ] Тестировал на разных устройствах
- [ ] Звуки настроены
- [ ] FPS нормальный (30+)

### На itch.io:
- [ ] Загрузил APK
- [ ] Написал описание
- [ ] Добавил теги: horror, 3d, godot
- [ ] Опубликовал

### На Google Play (опционально):
- [ ] Подписал APK
- [ ] Добавил скриншоты
- [ ] Написал описание
- [ ] Ждёшь одобрения

## 📊 Статистика (чего ожидать)

- **Itch.io**: 10-100 скачиваний в первый день
- **Google Play**: 1000-5000 скачиваний в месяц
- **Рейтинг**: Обычно 4-5 звёзд если игра хорошая

## 🎊 Поздравляю!

Ты опубликовал свою игру! 🎮🎉

Теперь:
1. Собирай отзывы
2. Улучшай игру
3. Добавляй новое
4. Зарабатывай (если хочешь - через ads/IAP)

**Дальше только вверх! 🚀**
