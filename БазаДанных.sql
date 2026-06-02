-- 1. Создание базы данных
CREATE DATABASE [TradeDB];
GO
USE [TradeDB];
GO

-- ============================================================================
-- ТАБЛИЦЫ БЕЗ ВНЕШНИХ СВЯЗЕЙ (Справочники)
-- ============================================================================

-- Таблица: Роли пользователей
CREATE TABLE [Role] (
    [IDRole] INT IDENTITY(1,1) NOT NULL,
    [RoleSotrudnika] NVARCHAR(50) NULL,
    CONSTRAINT [PK_Role] PRIMARY KEY CLUSTERED ([IDRole] ASC)
);

-- Таблица: Пункты выдачи
CREATE TABLE [PunctVidachi] (
    [IDPunctVidachi] INT IDENTITY(1,1) NOT NULL,
    [Indeks] INT NULL,
    [Adres] NVARCHAR(MAX) NULL,
    CONSTRAINT [PK_PunctVidachi] PRIMARY KEY CLUSTERED ([IDPunctVidachi] ASC)
);

-- Таблица: Статусы заказа
CREATE TABLE [StatysZakaz] (
    [IDStatysZakaz] INT IDENTITY(1,1) NOT NULL,
    [NameStatysZakaza] NVARCHAR(50) NULL,
    CONSTRAINT [PK_StatysZakaz] PRIMARY KEY CLUSTERED ([IDStatysZakaz] ASC)
);

-- Таблица: Поставщики
CREATE TABLE [Postavchik] (
    [IDPostavchik] INT IDENTITY(1,1) NOT NULL,
    [PostavchikName] NVARCHAR(50) NULL,
    CONSTRAINT [PK_Postavchik] PRIMARY KEY CLUSTERED ([IDPostavchik] ASC)
);

-- Таблица: Производители
CREATE TABLE [Proizvoditel] (
    [IDProizvoditel] INT IDENTITY(1,1) NOT NULL,
    [NameProizvoditel] NVARCHAR(50) NULL,
    CONSTRAINT [PK_Proizvoditel] PRIMARY KEY CLUSTERED ([IDProizvoditel] ASC)
);

-- Таблица: Наименования товаров
CREATE TABLE [NameTovar] (
    [IDNameTovar] INT IDENTITY(1,1) NOT NULL,
    [NaimenovanieTovara] NVARCHAR(50) NULL,
    CONSTRAINT [PK_NameTovar] PRIMARY KEY CLUSTERED ([IDNameTovar] ASC)
);

-- Таблица: Категории товаров
CREATE TABLE [Kategor] (
    [IDKategorTovar] INT IDENTITY(1,1) NOT NULL,
    [NameKategor] NVARCHAR(50) NULL,
    CONSTRAINT [PK_Kategor] PRIMARY KEY CLUSTERED ([IDKategorTovar] ASC)
);


-- ============================================================================
-- ТАБЛИЦЫ С ВНЕШНИМИ СВЯЗЯМИ (Сущности второго уровня)
-- ============================================================================

-- Таблица: Пользователи
CREATE TABLE [User] (
    [IDUser] INT IDENTITY(1,1) NOT NULL,
    [Role] INT NOT NULL, -- На схеме снята галочка "Разрешить NULL"
    [Surname] NVARCHAR(50) NULL,
    [Name] NVARCHAR(50) NULL,
    [Otchestvo] NVARCHAR(50) NULL,
    [Login] NVARCHAR(50) NULL,
    [Parol] NVARCHAR(50) NULL,
    CONSTRAINT [PK_User] PRIMARY KEY CLUSTERED ([IDUser] ASC),
    CONSTRAINT [FK_User_Role] FOREIGN KEY ([Role]) REFERENCES [Role]([IDRole])
);

-- Таблица: Заказы
CREATE TABLE [Zakaz] (
    [NomerZakaza] INT IDENTITY(1,1) NOT NULL,
    [DataZakaza] DATE NULL,
    [DataDostavki] DATE NULL,
    [AdresPunktaVidachi] INT NULL,
    [IDUser] INT NULL,
    [KodDlyaPoluchenia] INT NULL,
    [StatusZakaza] INT NULL,
    CONSTRAINT [PK_Zakaz] PRIMARY KEY CLUSTERED ([NomerZakaza] ASC),
    CONSTRAINT [FK_Zakaz_PunctVidachi] FOREIGN KEY ([AdresPunktaVidachi]) REFERENCES [PunctVidachi]([IDPunctVidachi]),
    CONSTRAINT [FK_Zakaz_User] FOREIGN KEY ([IDUser]) REFERENCES [User]([IDUser]),
    CONSTRAINT [FK_Zakaz_StatysZakaz] FOREIGN KEY ([StatusZakaza]) REFERENCES [StatysZakaz]([IDStatysZakaz])
);

-- Таблица: Товары
CREATE TABLE [Tovar] (
    [IDTovar] INT IDENTITY(1,1) NOT NULL,
    -- Уникальный индекс необходим, чтобы на это поле можно было ссылаться из TovarZakaz
    [Articul] NVARCHAR(50) NOT NULL CONSTRAINT [UQ_Tovar_Articul] UNIQUE, 
    [Name] INT NULL,
    [EdinichaIzmerenia] NVARCHAR(50) NULL, -- Если в ТЗ допущена опечатка "Edinichalzmerenia" с буквой 'l', замените здесь
    [Chena] INT NULL,
    [Postavchik] INT NULL,
    [Proizvoditel] INT NULL,
    [KategoriaTovar] INT NULL,
    [DeistvuiuchaiaSkidka] INT NULL,
    [KolVoNaSklade] INT NULL,
    [OpisanieTovara] NVARCHAR(MAX) NULL,
    [Foto] NVARCHAR(MAX) NULL,
    CONSTRAINT [PK_Tovar] PRIMARY KEY CLUSTERED ([IDTovar] ASC),
    CONSTRAINT [FK_Tovar_NameTovar] FOREIGN KEY ([Name]) REFERENCES [NameTovar]([IDNameTovar]),
    CONSTRAINT [FK_Tovar_Postavchik] FOREIGN KEY ([Postavchik]) REFERENCES [Postavchik]([IDPostavchik]),
    CONSTRAINT [FK_Tovar_Proizvoditel] FOREIGN KEY ([Proizvoditel]) REFERENCES [Proizvoditel]([IDProizvoditel]),
    CONSTRAINT [FK_Tovar_Kategor] FOREIGN KEY ([KategoriaTovar]) REFERENCES [Kategor]([IDKategorTovar])
);

-- Таблица: Содержимое заказа (Связующая таблица)
CREATE TABLE [TovarZakaz] (
    [IDTovarZakaz] INT IDENTITY(1,1) NOT NULL,
    [NomerZakaza] INT NULL,
    [Articul] NVARCHAR(50) NULL,
    [Kolichestvo] INT NULL,
    CONSTRAINT [PK_TovarZakaz] PRIMARY KEY CLUSTERED ([IDTovarZakaz] ASC),
    CONSTRAINT [FK_TovarZakaz_Zakaz] FOREIGN KEY ([NomerZakaza]) REFERENCES [Zakaz]([NomerZakaza]),
    CONSTRAINT [FK_TovarZakaz_Tovar] FOREIGN KEY ([Articul]) REFERENCES [Tovar]([Articul])
);
