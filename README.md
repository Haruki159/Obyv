<img width="1405" height="648" alt="image" src="https://github.com/user-attachments/assets/fd9a18f3-443e-4820-9a10-34a3939f5d92" />

---

# ShoesShop — Магазин Обуви

WPF-приложение (C# / .NET) для автоматизации процессов заказа, продажи и администрирования ассортимента обувного магазина. Проект разработан с использованием архитектуры MS SQL Server и технологии Entity Framework для работы с базой данных.

---

## 🗄️ База данных

Схема данных развернута на MS SQL Server. Скрипт для создания структуры таблиц и связей находится в корне репозитория:
* 📄 [БазаДанных.sql](БазаДанных.sql) — SQL-скрипт для создания таблиц базы данных.
* 🗺️ [DataBase.edmx](ShoesShop/DataBase/DataBase.edmx) — ADO.NET Entity Data Model, описывающая схему связей базы данных внутри WPF-проекта.

---

## 🖥️ Окна и страницы приложения

Ниже представлены прямые ссылки на ключевые файлы исходного кода проекта в соответствии со структурой решения:

### Главные компоненты и конфигурация
* 🔑 [MainWindow.xaml](ShoesShop/MainWindow.xaml) / [MainWindow.xaml.cs](ShoesShop/MainWindow.xaml.cs) — Главное окно приложения, выступающее в роли контейнера для навигации по страницам.
* ⚙️ [App.xaml](ShoesShop/App.xaml) / [App.xaml.cs](ShoesShop/App.xaml.cs) — Глобальные ресурсы, стили и точка запуска приложения.
* 🛠️ [App.config](ShoesShop/App.config) — Конфигурационный файл приложения (содержит строку подключения к базе данных `connectionStrings`).

### Классы и логика
* 📁 [Manager.cs](ShoesShop/Class/Manager.cs) — Вспомогательный класс для реализации логики переходов (навигации) между страницами и окнами.

### Страницы (Pages)
* 🛍️ [ProductsPage.xaml](ShoesShop/Pages/ProductsPage.xaml) / [ProductsPage.xaml.cs](ShoesShop/Pages/ProductsPage.xaml.cs) — Страница каталога обуви. Отвечает за вывод списка товаров, поиск, фильтрацию по категориям/производителям и сортировку.

### Окна (Windows)
* 🔒 [LoginWindow.xaml](ShoesShop/Windows/LoginWindow.xaml) / [LoginWindow.xaml.cs](ShoesShop/Windows/LoginWindow.xaml.cs) — Окно авторизации для пользователей системы с разграничением прав доступа.
* ✍️ [AddEditWindow.xaml](ShoesShop/Windows/AddEditWindow.xaml) / [AddEditWindow.xaml.cs](ShoesShop/Windows/AddEditWindow.xaml.cs) — Окно редактирования и добавления новых товаров в базу данных (доступно для администратора/менеджера).

---

## 🛠️ Технологический стек

* **Платформа:** .NET Framework
* **Интерфейс:** WPF (XAML)
* **Архитектурный шаблон:** Code-Behind / Элементы MVVM
* **СУБД:** MS SQL Server
* **ORM:** Entity Framework (Database-First)
* **Среда разработки:** Visual Studio

---

## 🚀 Инструкция по локальному запуску

1. **Клонирование репозитория:**
   ```bash
   git clone https://github.com/Haruki159/Obyv.git
