# 📱 УСТАНОВКА НА TERMUX (Твой Android-планшет)

## ШАГ 1: Установка зависимостей

```bash
# Обнови пакеты
pkg update
pkg upgrade

# Установи git и Java
pkg install git openjdk-17
```

## ШАГ 2: Клонирование проекта

```bash
# Перейди в папку
cd ~

# Клонируй
git clone https://github.com/твой-юзер/hollow-horror.git
cd hollow-horror
```

## ШАГ 3: Скачивание Godot

```bash
# Для Termux версия ARM64:
wget https://downloads.tuxfamily.org/godotengine/4.2/Godot_v4.2-stable_linux_arm64.zip

# Распакуй
unzip Godot_v4.2-stable_linux_arm64.zip
chmod +x Godot_v4.2-stable_linux_arm64
```

## ШАГ 4: Запуск Godot Editor

```bash
# Если хочешь через SSH на ПК:
export DISPLAY=:0
./Godot_v4.2-stable_linux_arm64 --main-pack hollow-horror

# Или просто открой проект в редакторе
./Godot_v4.2-stable_linux_arm64
```

## ШАГ 5: Сборка APK на планшете

```bash
# Установи Android SDK
pkg install android-tools

# Экспортируй проект
./Godot_v4.2-stable_linux_arm64 -v --export-release "Android" "hollow.apk"
```

## ⚠️ ВАЖНЫЕ ЗАМЕЧАНИЯ

1. **Производительность**: На планшете сборка может идти долго (30+ мин)
2. **Памяти**: Нужно минимум 4GB свободно
3. **Батарея**: Подключи зарядку перед сборкой
4. **Интернет**: Stable соединение

## 🚀 Если что-то не работает

```bash
# Проверь Java
java -version

# Проверь Android SDK
sdkmanager --list

# Проверь интернет
ping google.com
```

## БЫСТРЫЙ СПОСОБ: Использовать GitHub Actions

1. Push проект на GitHub
2. GitHub Actions сделает APK
3. Скачай на планшет
4. Установи и запусти!

**Это НАМНОГО быстрее чем собирать на планшете!** ⚡
