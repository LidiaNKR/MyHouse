# MyHouse


Это iOS приложение, которое отображает камеры в комнатах дома и на дверях.

# Интерфейс
Приложение отображает камеры в доме, имеет функционал добавления/удаления камер и дверей в избранное.
Также имеет функционал редактирования названия дверей.

Основные классы:

1. ContainerViewController, который представляет TableViewController, в зависимости от выбранной вкладки.

<p align="center" width="100%">
    <img width="30%" src="https://github.com/LidiaNKR/MyHouse/blob/b1c5ee600a3ea62eba2f558d087c437cb4f2193a/Images/Camera.png">
    <img width="30%" src="https://github.com/LidiaNKR/MyHouse/blob/b1c5ee600a3ea62eba2f558d087c437cb4f2193a/Images/Door.png">
</p>

2. CamerasTableViewController, отображающий камеры в доме. Если данных в базе Realm нет, то данные грузятся из сети и сохраняются в Realm. При свейпе экран вниз происходит загрузка и обновление данных из сети. Имеет функционал добавления/удаления камеры в избранное. 

<p align="center" width="100%">
    <img width="30%" src="https://github.com/LidiaNKR/MyHouse/blob/b1c5ee600a3ea62eba2f558d087c437cb4f2193a/Images/CameraEdit.png">
</p>

3. DoorsTableViewController, отображающий камеры у дверей. Если данных в базе Realm нет, то данные грузятся из сети и сохраняются в Realm. При свейпе экран вниз происходит загрузка и обновление данных из сети. Имеет функционал добавления/удаления камеры в избранное и редактирования названия камеры.

<p align="center" width="100%">
    <img width="30%" src="https://github.com/LidiaNKR/MyHouse/blob/b1c5ee600a3ea62eba2f558d087c437cb4f2193a/Images/DoorEdit.png">
    <img width="30%" src="https://github.com/LidiaNKR/MyHouse/blob/b1c5ee600a3ea62eba2f558d087c437cb4f2193a/Images/DoorNameEdit.png">
</p>

4. DescriptionViewController, отображает информацию о камере у двери.

<p align="center" width="100%">
    <img width="30%" src="https://github.com/LidiaNKR/MyHouse/blob/b1c5ee600a3ea62eba2f558d087c437cb4f2193a/Images/DoorDescription.png">
</p>

# Дополнение к установка проекта
1. Установить [CocoaPods](https://guides.cocoapods.org/using/getting-started.html)
2. Открыть деррикторию проекта в терминале и вызвать комманду `pod install`
3. В папке проекта открыть файл `*.xcworkspace`

# Используемый стек технологий
- Язык программирования - `Swift`
- Интерфейс - `UIKit`
- Архитектура - `MVС`
- Верстка интерфейса - `StoreyBoard`
- Frameworks: `Realm`
- iOS 13+
