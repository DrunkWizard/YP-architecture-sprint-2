# Решение четвертой части задания второго сринта
- Для запуска проекта нужно запустить bash скрипт [mongo-init.sh](./scripts/mongo-init.sh).
- Файл с диаграммой, описывающей решение [YP-2sprint-sharding-repl-cache](./YP-2sprint-sharding-repl-cache.drawio). 

Также для лучшей отказоустойчивости можно реплицировать mongo router и config server.  
А для лучшей читаемости разнести compose.yaml по разным файлам