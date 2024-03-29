# Д/З до уроку 9: Vacancies
Застосунок який дозволяє створювати та передивлятись компанії та вакансії від них.

## Функціонал:
 - Подивитись список вакансій. При кліку на вакансію вона відкривається на окремому екрані.
 <p float="left">
    <img src="https://user-images.githubusercontent.com/101039162/225594811-5872d7b4-573c-4a6c-9036-f66033e1df3a.jpg" alt="Preview" height="500px"/>
    <img src="https://user-images.githubusercontent.com/101039162/225591524-13895aec-6c0d-47ff-a657-7b237c318643.jpg" alt="Preview" height="500px"/>
    <img src="https://user-images.githubusercontent.com/101039162/225591522-6f7f6525-910a-4c51-bd2b-f71dbf772499.jpg" alt="Preview" height="500px"/>
</p>
 - Подивитись список компаній. При кліку на компанію вона відкривається на окремому екрані. Також на цьому екрані відображаться список всіх вакансій цієї компанії.
 <p float="left">
    <img src="https://user-images.githubusercontent.com/101039162/225591527-174e6ca6-4fe0-4055-b197-c09b2b853be6.jpg" alt="Preview" height="500px"/>
    <img src="https://user-images.githubusercontent.com/101039162/225592378-0560b778-7903-4c17-bcdb-8a43a60f1ae4.jpg" alt="Preview" height="500px"/>
</p>

Демо-відео застосунку:

<table width="100%">
<tr>
  <td align="left" valign="top" width="25%">
<video autoplay="autoplay" muted="true" loop="loop" controls="controls" src="https://user-images.githubusercontent.com/101039162/225660344-3d197e50-48aa-41e8-880f-4a2031c03ec9.mp4" type="video/mp4"  ></video>
 </td>
 <td align="left" valign="top" width="25%">
<video autoplay="autoplay" muted="true" loop="loop" controls="controls" src="https://user-images.githubusercontent.com/101039162/225660328-241d61a6-0083-41ed-9544-c44f0fdacf35.mp4" type="video/mp4"  ></video>
 </td>
<td align="left" valign="top" width="25%">
<video autoplay="autoplay" muted="true" loop="loop" controls="controls" src="https://user-images.githubusercontent.com/101039162/225660300-9a263dcc-8349-4d9e-ac4e-78ef02156dce.mp4" type="video/mp4"  ></video>
</td>
<td align="left" valign="top" width="25%">
<video autoplay="autoplay" muted="true" loop="loop" controls="controls" src="https://user-images.githubusercontent.com/101039162/225660316-35963cac-63fe-4bc3-a93d-43f9e682db16.mp4" type="video/mp4"  ></video>
 </td>
 

</tr>
</table>

 - Можливість додати та видалити компанію. При видаленні компанії видаляються всі її вакансії, якщо вони існують. 
 - Можливість додати та видалити вакансію. При додаванні можливо обрати компанію зі списку.
  <p float="left">
    <img src="https://user-images.githubusercontent.com/101039162/225594772-62f5e902-8dac-44e1-969f-ef001b2fefee.jpg" alt="Preview" height="500px"/>
    <img src="https://user-images.githubusercontent.com/101039162/225591516-2585f302-c3c3-4cc5-a622-279587b798bb.jpg" alt="Preview" height="500px"/>
</p>

</p>
 - Реалізовано пошук вакансій за назвою вакансії чи компанії. В пошуку можливо відсортувати знайдені результати за алфавітом, відфільтрувати за категорією та містом.
 <p float="left">
    <img src="https://user-images.githubusercontent.com/101039162/225590732-129c3371-24a7-4c31-9581-13309f48c703.jpg" alt="Preview" height="500px"/>
    <img src="https://user-images.githubusercontent.com/101039162/225590891-39f2471c-b173-4992-8bb6-4514ecd24f1a.jpg" alt="Preview" height="500px"/>
    <img src="https://user-images.githubusercontent.com/101039162/225590888-de429f70-efa0-45ca-9523-81aed210fe76.jpg" alt="Preview" height="500px"/>
    <img src="https://user-images.githubusercontent.com/101039162/225590879-19307967-db2f-490e-bbc6-00d96b0d30cd.jpg" alt="Preview" height="500px"/>
    <img src="https://user-images.githubusercontent.com/101039162/225590894-32b74621-c5b0-47df-9e8b-cc7b35dfe4f0.jpg" alt="Preview" height="500px"/>
</p>
 
 ## Архітектура:
 Застосунок створено відповідно до правил Clean architecture. Застосунок має три слої: Data, Domain, Presentation. На малюнку нижче вказані назви файлів та папок проекту відповідно до слоїв архітектури.
 
 <img src="https://user-images.githubusercontent.com/101039162/210007558-6266d848-6004-4771-9ae7-fa8a568c3347.jpg" alt="Preview" height="600px"/>
 
При створенні додатку використані наступні технології та бібліотеки: 
 - дані отримуються та зберігаються як на сервері, відповідно до заданих ендпоінтів, так і за допомогою бібліотек Dio та Http, а також локально в кеші девайсу за допомогою Shared Preferences, для того, щоб при відсутності інтернету (перевіряється через internet_connection_checker) завантажити останні дані, що були раніше взяті з серверу.
 - для реалізації залежностей Dependency Injection використаний шаблон Service locator із бібліотеки GetIt. 
 - для керування станом використовується Bloc - Cubit із бібліотеки flutter_bloc.

