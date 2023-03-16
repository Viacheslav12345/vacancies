# Д/З до уроку 9: Vacancies

## Функціонал:
 - Подивитись список вакансій. При кліку на вакансію вона відкривається на окремому екрані.
 <p float="left">
    <img src="https://user-images.githubusercontent.com/101039162/210006849-0ec8be3f-88d2-477a-b668-75748bb7a50b.jpg" alt="Preview" height="500px"/>
    <img src="https://user-images.githubusercontent.com/101039162/210007009-bf5eae9b-46dc-45de-b4b1-d49ac669370f.jpg" alt="Preview" height="500px"/>
</p>
 - Подивитись список компаній. При кліку на компанію вона відкривається на окремому екрані. Також на цьому екрані відображаться список всіх вакансій цієї компанії.
 <p float="left">
    <img src="https://user-images.githubusercontent.com/101039162/210006751-7b69533b-278f-4195-b0ad-f1fe60f34b17.jpg" alt="Preview" height="500px"/>
    <img src="https://user-images.githubusercontent.com/101039162/210007159-1998a47c-14cc-4bc2-a83f-05e3b7e61027.jpg" alt="Preview" height="500px"/>
</p>

 - Можливість додати та видалити компанію. 
 - Можливість додати та видалити вакансію. При додаванні можливо обрати компанію зі списку.
  <p float="left">
    <img src="https://user-images.githubusercontent.com/101039162/210007294-64e9a01f-e4a3-4431-acf4-82c2b1f3926c.jpg" alt="Preview" height="500px"/>
    <img src="https://user-images.githubusercontent.com/101039162/210007295-44d6a2e9-00cf-4ea2-9b23-0c9e0cdb1ffb.jpg" alt="Preview" height="500px"/>
</p>
 
 ## Архітектура:
 Застосунок створено відповідно до правил Clean architecture. Застосунок має три слої: Data, Domain, Presentation. На малюнку нижче вказані назви файлів та папок проекту відповідно до слоїв архітектури.
 
 <img src="https://user-images.githubusercontent.com/101039162/210007558-6266d848-6004-4771-9ae7-fa8a568c3347.jpg" alt="Preview" height="600px"/>
 
При створенні додатку використані наступні технології та бібліотеки: 
 - дані отримуються та зберігаються як на сервері, відповідно до заданих ендпоінтів, так і за допомогою бібліотек Dio та Http, а також локально в кеші девайсу за допомогою Shared Preferences, для того, щоб при відсутності інтернету (перевіряється через internet_connection_checker) завантажити останні дані, що були раніше взяті з серверу.
 - для реалізації залежностей Dependency Injection використаний шаблон Service locator із бібліотеки GetIt. 
 - для керування станом використовується Bloc - Cubit із бібліотеки flutter_bloc.

