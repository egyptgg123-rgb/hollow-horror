# Hollow: Horror - Indie 3D Horror Game

**Готовый 3D хоррор на Godot 4.2 для мобильника**

## 🎮 Описание игры

Криповый инди-хоррор с:
- ✅ 3D графикой и атмосферой
- ✅ AI врагами разных типов (Stalker, Crawler, Shadow)
- ✅ Системой боя с 3 типами оружия (пистолет, дробовик, ледяное оружие)
- ✅ Историей в диалогах
- ✅ Системой здоровья и амуниции
- ✅ Эффектами: кровь, взрывы, крио-ффекты

## 🚀 Быстрый старт

### Локально на ПК

1. **Установи Godot 4.2**
   ```bash
   # Linux/Mac
   wget https://downloads.tuxfamily.org/godotengine/4.2/Godot_v4.2-stable_linux.x86_64.zip
   unzip Godot_v4.2-stable_linux.x86_64.zip
   chmod +x Godot_v4.2-stable_linux.x86_64
   ```

2. **Клонируй проект**
   ```bash
   git clone https://github.com/твой-юзер/hollow-horror.git
   cd hollow-horror
   ```

3. **Открой в Godot**
   ```bash
   ./Godot_v4.2-stable_linux.x86_64
   ```
   Выбери папку проекта

4. **Жми Play** (F5)

### Сборка APK (с GitHub Actions)

#### Способ 1: Автоматически через GitHub (ЛЕГКО)

1. **Fork проект на GitHub**
2. **Зайди в Settings → Actions → General**
3. Выбери **Allow all actions and reusable workflows**
4. **Push любое изменение** на ветку main
5. **Жди ~15 минут** на вкладке Actions
6. **Скачай APK** из Artifacts

#### Способ 2: Локально на своем ПК

1. **Установи Android SDK/NDK**
   ```bash
   # Для Linux
   mkdir android_sdk
   cd android_sdk
   wget https://dl.google.com/android/repository/commandlinetools-linux-9477386_latest.zip
   unzip commandlinetools-linux-9477386_latest.zip
   mkdir -p cmdline-tools/latest
   mv cmdline-tools/* cmdline-tools/latest/
   
   export ANDROID_HOME=$(pwd)
   export PATH=$PATH:$ANDROID_HOME/cmdline-tools/latest/bin
   
   yes | sdkmanager --licenses
   sdkmanager "platforms;android-34" "build-tools;34.0.0" "ndk;26.1.10909125"
   ```

2. **Экспортируй из Godot**
   - Project → Export...
   - Выбери Android
   - Export Project
   - Выбери папку для сохранения

3. **APK готов!** Скачай и установи на телефон

## 📋 Структура проекта

```
hollow-horror/
├── scenes/              # Все сцены (.tscn файлы)
│   ├── main.tscn       # Главная сцена
│   ├── player.tscn     # Игрок
│   └── enemies/        # Врагов
├── scripts/            # GDScript код
│   ├── main.gd
│   ├── player/
│   ├── enemies/
│   ├── weapon/
│   └── managers/       # Audio, GameState
├── assets/             # Ассеты
│   ├── sounds/         # Звуки
│   ├── models/         # 3D модели
│   └── icon.png        # Иконка приложения
├── project.godot       # Конфиг проекта
└── export_presets.cfg  # Конфиг экспорта Android
```

## 🎮 Управление

- **WASD** - движение
- **Мышь** - камера (на ПК) / Сенсор (на телефоне)
- **Левый клик / Экран** - выстрел
- **Shift** - спринт
- **E** - взаимодействие
- **ESC** - меню

## 🔧 Как расширить

### Добавить врага

```gdscript
# scenes/enemies/new_enemy.tscn
extends "res://scripts/enemies/enemy_base.gd"

func _ready():
	super._ready()
	enemy_type = "my_monster"
	speed = 9.0
	damage = 15
```

### Добавить уровень

1. Создай новую сцену: `scenes/levels/level_2.tscn`
2. Дублируй главное меню (main.tscn)
3. Меняй spawn points и врагов
4. Добавь в main.gd переход на уровень

### Добавить диалог с историей

```gdscript
# В main.gd
var story_dialogs = [
	"Ты очнулся...",
	"Что-то движется в тени...",
	"Пора найти выход..."
]
```

## 📦 Публикация

### На Google Play

1. **Создай подписанный APK**
   - В Godot: Project → Export...
   - Нужен keystore файл (создай его один раз)
   
2. **Загрузи в Google Play Console**
   - developer.android.com
   - Create App
   - Upload APK
   - Жди одобрения (24-48 часов)

### На itch.io (быстро!)

1. Создай аккаунт на itch.io
2. Create new project
3. Upload -> Select `hollow.apk`
4. Mark as "Android"
5. Save

## 🐛 Решение проблем

**APK не собирается:**
- Проверь версии SDK (24-34)
- Убедись что Java установлена: `java -version`

**Падает на телефоне:**
- Минимум Android 7.0 (API 24)
- Минимум 1GB ОЗУ

**Звуки не работают:**
- Добавь звуковые файлы в `assets/sounds/`
- Проверь пути в audio_manager.gd

## 📊 Performance

- Оптимизировано для мобильников
- FPS: 60 (настраивается в project.godot)
- Использует mobile renderer
- Меньше 50MB APK

## 🎨 Расширение контента

Готовые места для добавления:
- [ ] Больше врагов (боссы?)
- [ ] Уровни
- [ ] Оружие
- [ ] Предметы
- [ ] Головоломки
- [ ] История

## 📱 Требования

- **ПК**: Godot 4.2+, Java 11+
- **Телефон**: Android 7.0+ (API 24)
- **Место на диске**: 1GB для разработки, 50MB для игры

## 📝 Лицензия

MIT License - используй как хочешь!

---

**Готово! Теперь:**
1. Fork проект
2. Push на GitHub
3. GitHub Actions собирает APK
4. Скачай и публикуй! 🚀
