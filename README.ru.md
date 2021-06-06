[TOC]

# CMakeFlameResolver

Небольшая CMake-библиотека для отложенного добавления целей внутри проектов, написанных на C или C++ и разршения зависимостей внутри проектов.

## Принцип работы с библиотекой

* В любом порядке добавляются цели через функции `flame_header_library()`, `flame_compile_library()` и `flame_compile_binary()`.
* В конце вызывается функция `flame_resolve()`
* ...
* PROFIT!

## Совместимость

Библиотеку можно использовать совместно со стандартным API СMake.

Минимально требуемая версия CMake 3.14.

Поддерживаемые компиляторы: GCC, Clang и MSVC.

## Включение библиотеки для использования

Необходимо добавить следующие строки в Ваш CMakeLists.txt либо подключаемый файл:

```cmake
list(APPEND CMAKE_MODULE_PATH "${RESOLVER_PATH}/cmake" PARENT_SCOPE)
include(CmakeFlameResolver)
```
где переменная `RESOLVER_PATH` -- путь до CMakeFlameResolver

## API

Далее для просты CMakeFlameResolver будет зваться просто "реслвером".

### Функции

* Добавление header-only билиотек либо заголовоков к экспортируемым библиотекам

    ```cmake
    flame_header_library(
        # Опции
        DEBUG

        # Параметры
        NAME
        LIBRARY_ALIAS_NAME
        INSTALL_PATH

        # Списки
        DEPENDENCY_TARGET_LIST
        HEADER_LIST
        INCLUDE_PATHS
    )
    ```

    | Имя                      |   Тип    | Описание                              |
    | ------------------------ | :------: | ------------------------------------- |
    | `DEBUG`                  |  Опция   | Включение отладочного вывода          |
    | `NAME`                   | Параметр | Имя библиотеки                        |
    | `LIBRARY_ALIAS_NAME`     | Параметр | Алиас библиотеки                      |
    | `INSTALL_PATH`           | Параметр | Путь установки. **Не поддерживается** |
    | `DEPENDENCY_TARGET_LIST` |  Список  | Список зависимых заголовков           |
    | `HEADER_LIST`            |  Список  | Список файлов                         |
    | `INCLUDE_PATHS`          |  Список  | Пути поиска заголовков                |

* Добавление компилирующейся части библиотек:

    ```cmake
    flame_compile_library(
        # Опции
        DEBUG
        MAKE_STATIC
        MAKE_SHARED
        NOT_MAKE_POSITION_DEPENDENT_OBJECTS
        NOT_MAKE_POSITION_INDEPENDENT_OBJECTS
        RTTI
        NO_RTTI
        EXCEPTIONS
        NO_EXCEPTIONS
        EXPORT_ALL
        USE_RESOLVER_DEFINES

        # Параметры
        NAME
        OBJECT_ALIAS_NAME
        INDEPENDENT_OBJECT_ALIAS_NAME
        STATIC_ALIAS_NAME
        SHARED_ALIAS_NAME
        STATIC_INSTALL_PATH
        SHARED_INSTALL_PATH

        # Списки
        DEFINES
        INCLUDE_PATHS
        SOURCE_LIST
        SOURCE_LIST_STATIC
        SOURCE_LIST_SHARED
        COMPILE_FLAGS
        LINK_FLAGS
        DEPENDENCY_HEADER_TARGETS
        DEPENDENCY_TARGETS_FOR_STATIC
        DEPENDENCY_TARGETS_FOR_SHARED
    )
    ```

    | Имя                                     |   Тип    | Описание                                                     |
    | --------------------------------------- | :------: | ------------------------------------------------------------ |
    | `DEBUG`                                 |  Опция   | Включение отладочного вывода                                 |
    | `MAKE_STATIC`                           |  Опция   | Сборка статической библиотеки                                |
    | `MAKE_SHARED`                           |  Опция   | Сборка динамической библиотеки                               |
    | `NOT_MAKE_POSITION_DEPENDENT_OBJECTS`   |  Опция   | Отключение сборки объектных файлов с позиционно-зависимым кодом (PIC). **Не поддерживается** |
    | `NOT_MAKE_POSITION_INDEPENDENT_OBJECTS` |  Опция   | Отключение сборки объектных файлов с позиционно-независимым кодом (PIC). **Не поддерживается** |
    | `RTTI`                                  |  Опция   | Включение поддержки RTTI (C++). Не совместимо с опцией `NO_RTTI` |
    | `NO_RTTI`                               |  Опция   | Отключение поддержки RTTI (C++). Не совместимо с опцией `RTTI` |
    | `EXCEPTIONS`                            |  Опция   | Включение поддержки исключений (C++). Не совместимо опцией `NO_EXCEPTIONS` |
    | `NO_EXCEPTIONS`                         |  Опция   | Отключение поддержки исключений (C++). Не совместимо опцией `EXCEPTIONS` |
    | `EXPORT_ALL`                            |  Опция   | Включение экспорта символов из динамической библиотеки       |
    | `USE_RESOLVER_DEFINES`                  |  Опция   | Включение макроопределений ресолвера                         |
    | `NAME`                                  | Параметр | Имя библиотеки                                               |
    | `OBJECT_ALIAS_NAME`                     | Параметр | Имя псевдонима библиотеки с объектными файлами               |
    | `INDEPENDENT_OBJECT_ALIAS_NAME`         | Параметр | Имя псевдонима библиотеки с позиционно-независимыми объектными файлами |
    | `STATIC_ALIAS_NAME`                     | Параметр | Имя псевдонима статической библиотеки                        |
    | `SHARED_ALIAS_NAME`                     | Параметр | Имя псевдонима динамической библиотеки                       |
    | `STATIC_INSTALL_PATH`                   | Параметр | Путь установки статической библиотеки. **Не поддерживается** |
    | `SHARED_INSTALL_PATH`                   | Параметр | Путь установки динамической библиотеки. **Не поддерживается** |
    | `DEFINES`                               |  Список  | Макроопределения                                             |
    | `INCLUDE_PATHS`                         |  Список  | Пути поиска заголовочных файлов                              |
    | `SOURCE_LIST`                           |  Список  | Список файлов                                                |
    | `SOURCE_LIST_STATIC`                    |  Список  | Дополнительный список файлов для статической библиотеки ***(?)*** |
    | `SOURCE_LIST_SHARED`                    |  Список  | Дополнительный список файлов для динамической библиотеки ***(?)*** |
    | `COMPILE_FLAGS`                         |  Список  | Дополнительный флаги компиляции                              |
    | `LINK_FLAGS`                            |  Список  | Флаги линковки                                               |
    | `DEPENDENCY_HEADER_TARGETS`             |  Список  | Список заголовков-зависимостей                               |
    | `DEPENDENCY_TARGETS_FOR_STATIC`         |  Список  | Список зависимостей статической библиотеки                   |
    | `DEPENDENCY_TARGETS_FOR_SHARED`         |  Список  | Список зависимостей динамической библиотеки                  |

* Добавление запускающихся файлов или тестов:

    ```cmake
    flame_compile_binary(
        # Опции
        DEBUG
        TEST
        RTTI
        NO_RTTI
        EXCEPTIONS
        NO_EXCEPTIONS
        USE_RESOLVER_DEFINES

        # Параметры
        NAME
        ALIAS_NAME
        INSTALL_PATH

        # Списки
        DEFINES
        INCLUDE_PATHS
        SOURCE_LIST
        COMPILE_FLAGS
        LINK_FLAGS
        DEPENDENCY_TARGET_LIST
        TEST_ARGUMENTS
    )
    ```

| Имя                      |    Тип    | Описание                           |
| :----------------------- | :-------: | ---------------------------------- |
| `DEBUG`                  |   Опция   | Включение отладочного вывода       |
| `TEST`                   |   Опция   | Итоговая программа является тестом |
| `RTTI`                                  |  Опция   | Включение поддержки RTTI (C++). Не совместимо с опцией `NO_RTTI` |
| `NO_RTTI`                               |  Опция   | Отключение поддержки RTTI (C++). Не совместимо с опцией `RTTI` |
| `EXCEPTIONS`                            |  Опция   | Включение поддержки исключений (C++). Не совместимо с опцией `NO_EXCEPTIONS` |
| `NO_EXCEPTIONS`                         |  Опция   | Отключение поддержки исключений (C++). Не совместимо с опцией `EXCEPTIONS` |
| `USE_RESOLVER_DEFINES`   |   Опция   | Включение макроопределений ресолвера |
| `NAME`                   | Параметры | Имя бинарного файла |
| `ALIAS_NAME`             | Параметры | Псевдоним цели |
| `INSTALL_PATH`           | Параметры | Путь установки. **Не поддерживается** |
| `DEFINES`                |  Списoк   | Макроопределения |
| `INCLUDE_PATHS`          |  Списoк   | Пути поиска заголовочных файлов |
| `SOURCE_LIST`            |  Списoк   | Список файлов |
| `COMPILE_FLAGS`          |  Списoк   | Дополнительные флаги компиляции |
| `LINK_FLAGS`             |  Списoк   | Дополнительные флаги линковки |
| `DEPENDENCY_TARGET_LIST` |  Списoк   | Список целей-зависимостей |
| `TEST_ARGUMENTS`         |  Списoк   | Аргументы запуска теста |

* Разрешение зависимостей и добавление целей сборки

    ```cmake
    flame_resolve_targets()
    ```

### Опции

#### Общие
* `FLAME_CMAKE_DEBUG` -- Запускать в дебажном режиме. По умолчанию `OFF`.
* `FLAME_CMAKE_DEBUG_SHOW_PARSE_RESULTS` -- В отладочном режиме будут выводиться результаты разбора параметров внутренних функций. По умолчанию `OFF`.
* `FLAME_PRINT_COMMON_STATISTIC` -- Вывести статистику после разрешения зависимостей. По умолчанию `OFF`. **Не поддерживается**
* `FLAME_PRINT_DETAILED_STATISTIC` -- Вывести полную статистику после разрешения зависимостей. По умолчанию `OFF`. **Не поддерживается**
* `FLAME_LOGGING` -- По умолчанию `OFF`.
* `FLAME_CLEAN_AFTER_RESOLVE` -- Очищать после добавления целей и разрешения зависимостей. По умолчанию `OFF`.
* `FLAME_THREADING` -- По умолчанию `OFF`.
* `FLAME_TESTING` -- Включение поддержки многопоточности. По умолчанию `OFF`.
* `FLAME_LOCAL_INSTALL` -- Установить локально, обходя переменные `CMAKE_INSTALL_*` По умолчанию `OFF`.

#### Генерация кода
* `FLAME_ONLY_POSITION_INDEPENDENT_OBJECTS` -- Указать глобально, чтобы собирались только позиционно-независимые объектные файлы. По умолчанию `OFF`.
* `FLAME_MAKE_STATIC` -- Собирать статические библиотеки. По умолчанию `OFF`.
* `FLAME_MAKE_SHARED` -- Собирать динамические библиотеки. По умолчанию `OFF`.
* `FLAME_MAKE_STANDALONE` -- По умолчанию `OFF`. **Не поддерживается**
* `FLAME_EXPORT_ALL_SYMBOLS` -- Если собираются динамические библиотеки, экспортировать все символы. По умолчанию `OFF`.

#### Флаги
* `FLAME_CXX_NO_RTTI` -- Собирать без поддержки исключений (C++). По умолчанию `OFF`.
* `FLAME_CXX_NO_EXCEPTIONS` -- Собирать без поддержки RTTI (C++). По умолчанию `OFF`.
* `FLAME_PLATFORM_DEFINES` -- Использовать макроопредения ресолвера. По умолчанию `OFF`.
