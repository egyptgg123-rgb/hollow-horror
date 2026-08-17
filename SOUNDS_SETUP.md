# 🔊 Добавление звуков в игру

Если звуки не работают, вот как их настроить:

## Шаг 1: Создай папку звуков

```bash
mkdir -p assets/sounds
```

## Шаг 2: Скачай звуковые эффекты

Используй бесплатные источники:
- **freesound.org** - Лучше всего
- **zapsplat.com** - Хорошие звуки
- **opengameart.org** - Для игр

### Список нужных звуков:

```
assets/sounds/
├── pistol.ogg          # Выстрел пистолета
├── shotgun.ogg         # Выстрел дробовика
├── ice.ogg             # Ледяной луч
├── footstep.ogg        # Шаги
├── player_hit.ogg      # Урон игроку
├── death.ogg           # Смерть
├── growl.ogg           # Рычание монстра
├── attack.ogg          # Атака врага
├── monster_death.ogg   # Смерть врага
├── equip.ogg           # Смена оружия
└── victory.ogg         # Победа
```

## Шаг 3: Конвертируй в OGG

Формат: **OGG Vorbis**

### Быстрая конвертация (ffmpeg):

```bash
# Linux/Mac/Windows(WSL)
ffmpeg -i sound.mp3 -c:a libvorbis -q:a 5 sound.ogg

# Или используй online конвертер:
# https://audio-online-converter.com
```

## Шаг 4: Проверь что работает

В Godot:
```
- Кликни на звук
- Инспектор → Нажми иконку Play
- Слышишь звук? ✅ Готово!
```

## Шаг 5: Если не работает

```gdscript
# Проверь в audio_manager.gd:
func load_sound(name: String, path: String):
    if ResourceLoader.exists(path):
        sound_effects[name] = load(path)
    else:
        print("ЗВУК НЕ НАЙДЕН: ", path)
```

Запусти игру → Посмотри консоль → Увидишь ошибку

## Генерация звуков без скачивания

### Используй Audacity (бесплатно):
1. Скачай Audacity
2. Generate → Tone/Noise
3. Экспортируй как OGG

### Используй GarageBand (Mac):
1. Создай новый трек
2. Запиши звук
3. Export → OGG Vorbis

## Минимальный набор (если лень)

Если совсем лень, удали из audio_manager.gd все ненужные звуки:

```gdscript
# Удали эти строки:
load_sound("ice_shot", "res://assets/sounds/ice.ogg")
load_sound("growl", "res://assets/sounds/growl.ogg")
# И так далее...
```

Оставь только самые важные:
- Выстрелы
- Шаги
- Смерть

## Готовые бесплатные паки

- OpenGameArt - Лучше всего для игр
- Zapsplat - Качественные звуки
- Freesound - Много выбора (проверяй лицензию!)

**Готово! Теперь в игре будет звук!** 🔊
