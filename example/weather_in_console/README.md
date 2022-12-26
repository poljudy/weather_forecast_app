A sample command-line application designed to retrieve weather data 
with an entrypoint in `bin/`, library code in `lib/`.

<!--
TODO: Подробный разбор данного приложения представлен здесь (RU):
![](ссылка на хабр)
-->

You can start the application by using the command:
```shell
dart run --define="API_WEATHER=YOUR_APIKEY" bin/main.dart
```

Compile into an executable file, e.g. `.exe`:
```shell
dart compile exe bin/main.dart --define="API_WEATHER=YOUR_APIKEY"
```

The block diagram of the application is shown below (RU):
```mermaid
%%{init: {'theme': 'forest'}}%%

flowchart TB
  Start(["Старт ( bin/main.dart )"])
  
  Start -->
  computeCheckApiKey["Проверка api-ключа"] -->
  checkApiKey{"Api-ключ корректный?"}
  --false--> exit1["Стоп ( exit(1) )"] --> End
   
  checkApiKey
  --true--> inputPlace[/"Введите местоположение"/]
  --> computeCheckInputPlace{"Проверка местоположения"}
  --Пустой ввод--> inputPlaceAgain{"Местоположение не указано. Попробовать ещё раз?"} 
  --false--> exit2["Стоп ( exit(0) )"] --> End
  
  inputPlaceAgain --true--> inputPlace
  
  computeCheckInputPlace --Не найдено--> inputPlace
  
  computeCheckInputPlace 
  --Найдено--> selectDesiredPlace[/"Выберите подходящее место"/]
  --> selectWeatherType[/"Выберите тип погодных данных"/]
  --"...получаем погодные данные..."--> printWeather[/"Отобразить полученные данные"/]
  
  printWeather -->
  inputIsRepeat{Узнать для другого города?}
  --false--> exit3["Стоп ( exit(0) )"] --> End
  inputIsRepeat --true--> inputPlace

End(["Конец"])
```
