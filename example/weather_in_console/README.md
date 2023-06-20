A sample command-line application designed to retrieve weather data
with an entrypoint in `bin/`, library code in `lib/`.

![](assets/result_in_console.gif)

A detailed analysis of this application is presented as an article and can be found here:


You can start the application by using the command:
```shell
dart run --define="API_WEATHER=YOUR_APIKEY" bin/main.dart
```

Compile into an executable file, e.g. `.exe`:
```shell
dart compile exe bin/main.dart --define="API_WEATHER=YOUR_APIKEY"
```

The block diagram of the application is shown below:

<details><summary>In Russian (Click to open)</summary>

```mermaid
%%{init: {'theme': 'forest'}}%%

flowchart TB
  Start(["Старт ( bin/main.dart )"])
  
  Start -->
  computeCheckApiKey["Проверка api-ключа"] -->
  checkApiKey{{"Api-ключ корректный?"}}
  --false--> exit1["Стоп ( exit(1) )"] --> End
  
  checkApiKey
  --true--> inputPlace[/"Введите местоположение"/]
  --> computeCheckInputPlace{{"Проверка местоположения"}}
  --"Пустой ввод"--> inputPlaceAgain{{"Местоположение не указано. Попробовать ещё раз?"}}
  --false--> exit2["Стоп ( exit(0) )"] --> End
  
  inputPlaceAgain --true--> inputPlace
  
  computeCheckInputPlace --"Не найдено"--> inputPlace
  
  computeCheckInputPlace
  --"Найдено"--> selectDesiredPlace[/"Выберите подходящее место"/]
  --> selectWeatherType[/"Выберите тип погодных данных"/]
  --"...получаем погодные данные..."--> printWeather[/"Отобразить полученные данные"/]
  
  printWeather -->
  inputIsRepeat{{"Узнать для другого города?"}}
  --false--> exit3["Стоп ( exit(0) )"] --> End
  inputIsRepeat --true--> inputPlace
  
End(["Конец"])
```

</details>

```mermaid

%%{init: {'theme': 'forest'}}%%

graph TB
  Start(["Start ( bin/main.dart )"])
  
  Start -->
  computeCheckApiKey["Checking the api key"] -->
  checkApiKey{{"Is the api key correct?"}}
  --false--> exit1["Stop ( exit(1) )"] --> End
   
  checkApiKey
  --true--> inputPlace[/"Enter a location"/]
  --> computeCheckInputPlace{{"Location check"}}
  --"Blank input"--> inputPlaceAgain{{"The location is not specified. Shall I try again?"}} 
  --false--> exit2["Stop ( exit(0) )"] --> End
  
  inputPlaceAgain --true--> inputPlace
  
  computeCheckInputPlace --"Not found"--> inputPlace
  
  computeCheckInputPlace 
  --"Found"--> selectDesiredPlace[/"Choose the right place"/]
  --> selectWeatherType[/"Select the type of weather data"/]
  --"...get weather data..."--> printWeather[/"Display the data obtained"/]
  
  printWeather -->
  inputIsRepeat{{"Find out for another city?"}}
  --false--> exit3["Stop ( exit(0) )"] --> End
  inputIsRepeat --true--> inputPlace

End(["EnD"])

```
