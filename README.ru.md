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

Необходимо добавить следующие строки в Ваш CMakeLists.txt либо в подключаемый файл:

```cmake
list(APPEND CMAKE_MODULE_PATH "${RESOLVER_PATH}/cmake" PARENT_SCOPE)
include(CmakeFlameResolver)
```
где переменная `RESOLVER_PATH` -- путь до CMakeFlameResolver

## API

Далее для просты CMakeFlameResolver будет зваться просто "ресолвером".

### Функции

* Настройки модуля

    ```cmake
    flame_resolver_settings(
        # Опции
        CMAKE_DEBUG
        CMAKE_DEBUG_SHOW_PARSE_RESULTS
        PRINT_COMMON_STATISTIC
        PRINT_DETAILED_STATISTIC
        LOGGING
        CLEAN_AFTER_RESOLVE
        THREADING
        TESTING
        INSTALL
        LOCAL_INSTALL

        ONLY_POSITION_INDEPENDENT_OBJECTS
        MAKE_STATIC
        MAKE_SHARED
        MAKE_STANDALONE
        EXPORT_ALL_SYMBOLS

        CXX_NO_RTTI
        CXX_NO_EXCEPTIONS
        PLATFORM_DEFINES
        WARNINGS
        WARNINGS_AS_ERRORS

        # Параметры
        PROJECT_ROOT_PATH
        LOCAL_INSTALL_PREFIX
        INSTALL_HEADER_DIR
        INSTALL_STATIC_DIR
        INSTALL_SHARED_DIR
        INSTALL_BINARY_DIR
    )
    ```

    | Имя                                 |   Тип    | Описание                              |
    | ----------------------------------- | :------: | :------------------------------------ |
    | `CMAKE_DEBUG`                       |  Опция   | Включение отладочного вывода |
    | `CMAKE_DEBUG_SHOW_PARSE_RESULTS`    |  Опция   | Вывод результатов разбора параметров внутренних функций. Будет работать вместе с активацией `CMAKE_DEBUG` |
    | `PRINT_COMMON_STATISTIC`            |  Опция   | Вывести статистику после разрешения зависимостей. **Не поддерживается** |
    | `PRINT_DETAILED_STATISTIC`          |  Опция   | Вывести полную статистику после разрешения зависимостей. **Не поддерживается** |
    | `LOGGING`                           |  Опция   | Включение логгирования |
    | `CLEAN_AFTER_RESOLVE`               |  Опция   | Очищать после добавления целей и разрешения зависимостей |
    | `THREADING`                         |  Опция   | Включение поддержки многопоточности |
    | `TESTING`                           |  Опция   | Включение добавления тестов в **CTest** |
    | `INSTALL`                           |  Опция   | Включение сценария установки |
    | `LOCAL_INSTALL`                     |  Опция   | Включить сценарий локальной установки, обходя переменные `CMAKE_INSTALL_*` |
    | `ONLY_POSITION_INDEPENDENT_OBJECTS` |  Опция   | Указать глобально, чтобы собирались только позиционно-независимые объектные файлы (в GCC опция `-fPIC`) |
    | `MAKE_STATIC`                       |  Опция   | Собирать статические библиотеки |
    | `MAKE_SHARED`                       |  Опция   | Собирать динамические библиотеки |
    | `MAKE_STANDALONE`                   |  Опция   | ***(?)*** |
    | `EXPORT_ALL_SYMBOLS`                |  Опция   | Если собираются динамические библиотеки, экспортировать все символы |
    | `CXX_NO_RTTI`                       |  Опция   | Собирать без поддержки исключений (C++) |
    | `CXX_NO_EXCEPTIONS`                 |  Опция   | Собирать без поддержки RTTI (C++) |
    | `PLATFORM_DEFINES`                  |  Опция   | Использовать макроопредения ресолвера |
    | `WARNINGS`                          |  Опция   | Включить предупреждения компилятора |
    | `WARNINGS_AS_ERRORS`                |  Опция   | Включить интерпретацию предупреждений как ошибкок (в GCC опция `-Werror`) |
    | `PROJECT_ROOT_PATH`                 | Параметр | Путь до корня проекта |
    | `LOCAL_INSTALL_PREFIX`              | Параметр | Путь локальной уставноки |
    | `INSTALL_HEADER_DIR`                | Параметр | Добавочная директория установки для заголовков |
    | `INSTALL_STATIC_DIR`                | Параметр | Добавочная директория установки для статических библиотек |
    | `INSTALL_SHARED_DIR`                | Параметр | Добавочная директория установки для динамических библиотек |
    | `INSTALL_BINARY_DIR`                | Параметр | Добавочная директория установки для запускающийся файлов |

* Добавление header-only билиотек либо заголовоков к экспортируемым библиотекам

    ```cmake
    flame_header_library(
        # Опции
        DEBUG

        # Параметры
        NAME
        LIBRARY_ALIAS_NAME
        INSTALL_PATH
        INSTALL_SUBDIR

        # Списки
        DEPENDENCY_TARGET_LIST
        HEADER_LIST
        INCLUDE_PATHS
    )
    ```

    | Имя                      |   Тип    | Описание                                                     |
    | ------------------------ | :------: | ------------------------------------------------------------ |
    | `DEBUG`                  |  Опция   | Включение отладочного вывода |
    | `NAME`                   | Параметр | Имя библиотеки |
    | `LIBRARY_ALIAS_NAME`     | Параметр | Алиас библиотеки |
    | `INSTALL_PATH`           | Параметр | Путь установки |
    | `INSTALL_SUBDIR`         | Параметр | Добавочная директория к префиксу, куда будут ставиться заголовчные файлы |
    | `DEPENDENCY_TARGET_LIST` |  Список  | Список зависимых заголовков |
    | `HEADER_LIST`            |  Список  | Список файлов |
    | `INCLUDE_PATHS`          |  Список  | Пути поиска заголовков |

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
        STATIC_INSTALL_SUBDIR
        SHARED_INSTALL_SUBDIR

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
    | `DEBUG`                                 |  Опция   | Включение отладочного вывода |
    | `MAKE_STATIC`                           |  Опция   | Сборка статической библиотеки |
    | `MAKE_SHARED`                           |  Опция   | Сборка динамической библиотеки |
    | `NOT_MAKE_POSITION_DEPENDENT_OBJECTS`   |  Опция   | Отключение сборки объектных файлов с позиционно-зависимым кодом (PIC). **Не поддерживается** |
    | `NOT_MAKE_POSITION_INDEPENDENT_OBJECTS` |  Опция   | Отключение сборки объектных файлов с позиционно-независимым кодом (PIC). **Не поддерживается** |
    | `RTTI`                                  |  Опция   | Включение поддержки RTTI (C++). Не совместимо с опцией `NO_RTTI` |
    | `NO_RTTI`                               |  Опция   | Отключение поддержки RTTI (C++). Не совместимо с опцией `RTTI` |
    | `EXCEPTIONS`                            |  Опция   | Включение поддержки исключений (C++). Не совместимо опцией `NO_EXCEPTIONS` |
    | `NO_EXCEPTIONS`                         |  Опция   | Отключение поддержки исключений (C++). Не совместимо опцией `EXCEPTIONS` |
    | `EXPORT_ALL`                            |  Опция   | Включение экспорта символов из динамической библиотеки |
    | `USE_RESOLVER_DEFINES`                  |  Опция   | Включение макроопределений ресолвера |
    | `NAME`                                  | Параметр | Имя библиотеки |
    | `OBJECT_ALIAS_NAME`                     | Параметр | Имя псевдонима библиотеки с объектными файлами |
    | `INDEPENDENT_OBJECT_ALIAS_NAME`         | Параметр | Имя псевдонима библиотеки с позиционно-независимыми объектными файлами |
    | `STATIC_ALIAS_NAME`                     | Параметр | Имя псевдонима статической библиотеки |
    | `SHARED_ALIAS_NAME`                     | Параметр | Имя псевдонима динамической библиотеки |
    | `STATIC_INSTALL_PATH`                   | Параметр | Путь установки статической библиотеки |
    | `SHARED_INSTALL_PATH`                   | Параметр | Путь установки динамической библиотеки |
    | `STATIC_INSTALL_SUBDIR`                 | Параметр | Добавочная директория к префиксу, куда будет ставиться статическая библиотека |
    | `SHARED_INSTALL_SUBDIR`                 | Параметр | Добавочная директория к префиксу, куда будет ставиться динамическая библиотека |
    | `DEFINES`                               |  Список  | Макроопределения |
    | `INCLUDE_PATHS`                         |  Список  | Пути поиска заголовочных файлов |
    | `SOURCE_LIST`                           |  Список  | Список файлов |
    | `SOURCE_LIST_STATIC`                    |  Список  | Дополнительный список файлов для статической библиотеки ***(?)*** |
    | `SOURCE_LIST_SHARED`                    |  Список  | Дополнительный список файлов для динамической библиотеки ***(?)*** |
    | `COMPILE_FLAGS`                         |  Список  | Дополнительные флаги компиляции |
    | `LINK_FLAGS`                            |  Список  | Флаги линковки |
    | `DEPENDENCY_HEADER_TARGETS`             |  Список  | Список целей с заголовочными файлами (т.е. INTERFACE-библиотеки) |
    | `DEPENDENCY_TARGETS_FOR_STATIC`         |  Список  | Список зависимостей статической библиотеки |
    | `DEPENDENCY_TARGETS_FOR_SHARED`         |  Список  | Список зависимостей динамической библиотеки |

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
        INSTALL_SUBDIR
    
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
| `RTTI`                   |   Опция   | Включение поддержки RTTI (C++). Не совместимо с опцией `NO_RTTI` |
| `NO_RTTI`                |   Опция   | Отключение поддержки RTTI (C++). Не совместимо с опцией `RTTI` |
| `EXCEPTIONS`             |   Опция   | Включение поддержки исключений (C++). Не совместимо с опцией `NO_EXCEPTIONS` |
| `NO_EXCEPTIONS`          |   Опция   | Отключение поддержки исключений (C++). Не совместимо с опцией `EXCEPTIONS` |
| `USE_RESOLVER_DEFINES`   |   Опция   | Включение макроопределений ресолвера |
| `NAME`                   | Параметр  | Имя бинарного файла |
| `ALIAS_NAME`             | Параметр  | Псевдоним цели |
| `INSTALL_PATH`           | Параметр  | Путь установки |
| `INSTALL_SUBDIR`         | Параметр  | Добавочная директория к префиксу, куда будет ставиться запускающийся файл |
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

Опции можно менять через функцию `flame_resolver_settings()`.

#### Общие
* `FLAME_CMAKE_DEBUG` -- Включение режима отладочного вывода. По умолчанию `OFF`.
* `FLAME_CMAKE_DEBUG_SHOW_PARSE_RESULTS` -- Вывод результатов разбора параметров внутренних функций. Будет работать вместе с активацией `FLAME_CMAKE_DEBUG`. По умолчанию `OFF`.
* `FLAME_PRINT_COMMON_STATISTIC` -- Вывести статистику после разрешения зависимостей. По умолчанию `OFF`. **Не поддерживается**
* `FLAME_PRINT_DETAILED_STATISTIC` -- Вывести полную статистику после разрешения зависимостей. По умолчанию `OFF`. **Не поддерживается**
* `FLAME_LOGGING` -- Включение логгирования. По умолчанию `ON`.
* `FLAME_CLEAN_AFTER_RESOLVE` -- Очищать после добавления целей и разрешения зависимостей. По умолчанию `OFF`.
* `FLAME_THREADING` -- Включение поддержки многопоточности. По умолчанию `OFF`.
* `FLAME_TESTING` -- Включение добавления тестов в **CTest**. По умолчанию `OFF`.
* `FLAME_LOCAL_INSTALL` -- Установить локально, обходя переменные `CMAKE_INSTALL_*` По умолчанию `OFF`.

#### Генерация кода
* `FLAME_ONLY_POSITION_INDEPENDENT_OBJECTS` -- Указать глобально, чтобы собирались только позиционно-независимые объектные файлы (опция GCC `-fPIC`). По умолчанию `OFF`.
* `FLAME_MAKE_STATIC` -- Собирать статические библиотеки. По умолчанию `ON`.
* `FLAME_MAKE_SHARED` -- Собирать динамические библиотеки. По умолчанию `ON`.
* `FLAME_MAKE_STANDALONE` -- По умолчанию `OFF`. **Не поддерживается**
* `FLAME_EXPORT_ALL_SYMBOLS` -- Если собираются динамические библиотеки, экспортировать все символы. По умолчанию `OFF`.

#### Флаги
* `FLAME_CXX_NO_RTTI` -- Собирать без поддержки исключений (C++). По умолчанию `OFF`.
* `FLAME_CXX_NO_EXCEPTIONS` -- Собирать без поддержки RTTI (C++). По умолчанию `OFF`.
* `FLAME_PLATFORM_DEFINES` -- Использовать макроопредения ресолвера. По умолчанию `OFF`.
* `FLAME_WARNINGS` -- Включить предупреждения компилятора. По умолчанию `ON`.
* `FLAME_WARNINGS_AS_ERRORS` -- Включить интерпретацию предупреждений как ошибкок (в GCC опция `-Werror`). По умолчанию `OFF`.

### Некэшируемые переменные

* `FLAME_PROJECT_ROOT_PATH` -- Путь до корня проекта. По умолчанию `${CMAKE_CURRENT_SOURCE_DIR}`
* `FLAME_LOCAL_INSTALL_PREFIX` -- Путь локальной установки. По умолчанию `${CMAKE_CURRENT_SOURCE_DIR}/install`
