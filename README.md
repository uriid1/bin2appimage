# bin2appimage

Попытка упаковывать бинарные программы со всеми зависимостями в единый AppImage.

## Зависимости

- `wget` - Для загрузки linuxdeploy. 
- `imagemagick` - Конвертация иконок.
- `linuxdeploy` - Автоматизация сборки. (Должен находится в корне репозитория).<br>

*Автоматическая загрузка linuxdeploy x86_64*

```bash
bash deps.sh
```

## Идея

 - Для сборки предлагается использовать универсальный скрипт, который на основе конфигурации должен будет сделать всё за вас.
 - Для больших программ, скорее всего, придется использовать свои скрипты сборки (пример cmake), которые будут находится по пути `apps/<app_name>/build`.
 - Все что нужно для минимальной сборки - конфиг и уже скомпилированный бинарный файл.

## Пример сборки nodejs

1. Перейти в `apps/node`
2. Выполнить `bash ../../scripts/build`
3. В случае успеха `AppImage` с имемем `node` будет в директории `bin2appimage/builds`.

## Сборка cmake

> [!WARNING]  
> Идея упаковывать cmake в AppImage не очень хорошая.
> Могут возникнут проблемы, тогда лучше просто прописать пути до модулей и нужной версии cmake.

Cmake для правильной работы нужны модули, которые находятся в `/usr/share/cmake-<version>`.

Поэтому для сборки нужной версии cmake предлагается использовать нужный релиз [CMake](https://github.com/Kitware/CMake/releases).

Пример сборки cmake v3.31.8
```bash
cd apps/cmake-3.31.8
bash build
```

После упаковки cmake в AppImage, для использования нужно прописать путь к директории, где лежит исполняемый файл.
```bash
export PATH=/path/to/dir:$PATH
```

## Песочница
Для обеспечения изоляции можно использовать 
[firejail](https://wiki.archlinux.org/title/Firejail_(%D0%A0%D1%83%D1%81%D1%81%D0%BA%D0%B8%D0%B9))

## Сборка всех утилит
```bash
cd apps
for dir in *;
do
  cd $dir
  [ -f build ] && bash build || bash ../../scripts/build
  cd ..
done
```

В одну строку
```bash
cd apps; for dir in *; do cd $dir; [ -f build ] && bash build || bash ../../scripts/build; cd ..; done
```
