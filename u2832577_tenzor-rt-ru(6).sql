-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Хост: localhost
-- Время создания: Фев 01 2025 г., 04:07
-- Версия сервера: 5.7.44-48
-- Версия PHP: 7.4.33

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- База данных: `u2832577_tenzor-rt-ru`
--

-- --------------------------------------------------------

--
-- Структура таблицы `authorised_users`
--

CREATE TABLE `authorised_users` (
  `userlogin` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `username` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `userpassword` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `userrole` varchar(10) COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Дамп данных таблицы `authorised_users`
--

INSERT INTO `authorised_users` (`userlogin`, `username`, `userpassword`, `userrole`) VALUES
('dunaev', 'Владислав Дунаев', '$2y$10$xYyWlZW3kkv9vw9gtH9GG.jp.Vsp3/ZpiqM6U9hC0EMkY0RgHpDhC', 'admin'),
('123', 'Kochergov', '$2y$10$MjRq6xuKwx/uQOoy2DGbAOtr8aHB9Y3HrGyvXyKzsiN9b2d05BD4i', 'waiter'),
('fuzetea', 'Касаткин Антон Витальевич', '$2y$10$qWbP2z0bLvLw8rbFZ7XJXe2m/TQNX0QUUfIGWT0BxGq2N/apDSVgy', 'waiter'),
('asya', 'Голубцова Анастасия Евгеньевна', '$2y$10$1B5vkrRk6HNsAkK8/vpRUuq.0cheh9RUb1pygMmO120hMJl20c9i2', 'notactive'),
('paradise', 'Ларионов Денис Сергеевич', '$2y$10$9e.sPQjvOY6BjnU9BiYITeD6tZ7.jnlDEjBNtFiumpIDaigYLugIK', 'cooker'),
('miha@225', 'Капустов Иван Михайлович', '$2y$10$TgksKjNm/8OQm05fypRme.m2GyNuoOZK0U3LG0bmSvGluSAAwq/4C', 'notactive'),
('Karp@228', 'Карпов Алексей Анатольевич', '$2y$10$kTCmUk64YB4xkU9sCyOf5.fecwZjbdjtiY.tXvu/o86mqHwFbLiLm', 'cooker'),
('VladislavDmitro', 'VladislavDmitro', '$2y$10$Xzbp8CO0Ks5YoeEE/JdJnuj3xoURRfRgpDEtuKQF72IyGrDCHfksC', 'admin');

-- --------------------------------------------------------

--
-- Структура таблицы `categories`
--

CREATE TABLE `categories` (
  `category_id` int(11) NOT NULL,
  `category_name` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Дамп данных таблицы `categories`
--

INSERT INTO `categories` (`category_id`, `category_name`) VALUES
(1, 'Термоконтейнеры'),
(2, 'Аккумуляторные батареи'),
(3, 'Зарядные устройства'),
(4, 'Радиоприёмники');

-- --------------------------------------------------------

--
-- Структура таблицы `customers`
--

CREATE TABLE `customers` (
  `customer_id` int(11) NOT NULL,
  `first_name` varchar(50) NOT NULL,
  `last_name` varchar(50) NOT NULL,
  `middle_name` varchar(50) DEFAULT NULL,
  `email` varchar(100) NOT NULL,
  `phone` varchar(20) NOT NULL,
  `address` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Структура таблицы `orders`
--

CREATE TABLE `orders` (
  `order_id` int(11) NOT NULL,
  `customer_id` int(11) NOT NULL,
  `order_date` datetime NOT NULL,
  `total_amount` decimal(10,2) NOT NULL,
  `status` varchar(20) NOT NULL,
  `delivery_address` text NOT NULL,
  `payment_method_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Структура таблицы `order_items`
--

CREATE TABLE `order_items` (
  `order_item_id` int(11) NOT NULL,
  `order_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `quantity` int(11) NOT NULL,
  `price` decimal(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Дамп данных таблицы `order_items`
--

INSERT INTO `order_items` (`order_item_id`, `order_id`, `product_id`, `quantity`, `price`) VALUES
(2, 1, 1, 2, '30000.00');

-- --------------------------------------------------------

--
-- Структура таблицы `payment_methods`
--

CREATE TABLE `payment_methods` (
  `payment_method_id` int(11) NOT NULL,
  `name` varchar(50) NOT NULL,
  `description` text
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Дамп данных таблицы `payment_methods`
--

INSERT INTO `payment_methods` (`payment_method_id`, `name`, `description`) VALUES
(1, 'Наличными при получении', 'Оплата наличными курьеру при доставке заказа'),
(2, 'Банковская карта онлайн', 'Оплата банковской картой через интернет при оформлении заказа'),
(3, 'СБП', 'Оплата через Систему Быстрых Платежей');

-- --------------------------------------------------------

--
-- Структура таблицы `products`
--

CREATE TABLE `products` (
  `product_id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `catalog_page_name` varchar(255) NOT NULL,
  `description` text,
  `category_id` int(11) DEFAULT NULL,
  `main_photo` varchar(255) DEFAULT NULL,
  `additional_photos` text,
  `page_name` varchar(255) NOT NULL,
  `page_description` text,
  `cost` decimal(10,2) NOT NULL DEFAULT '0.00'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Дамп данных таблицы `products`
--

INSERT INTO `products` (`product_id`, `name`, `catalog_page_name`, `description`, `category_id`, `main_photo`, `additional_photos`, `page_name`, `page_description`, `cost`) VALUES
(1, 'Аккумуляторная батарея серая', 'Аккумуляторные батареи повышенной емкости', 'Низкоемкие аккумуляторные батареи серые для длительной автономной работы.', 2, 'accum (1).jpg', '[\"180301119__ttx3.jpg\"]', 'Аккумуляторная батарея серая', 'Аккумуляторные батареи серые нашей компании разработаны для обеспечения длительной автономной работы. Они обладают высокой емкостью и надежной конструкцией, что делает их идеальными для различных промышленных и коммерческих применений. Батареи проходят строгие тесты на качество и безопасности, гарантируя их долгосрочную эксплуатацию.', '15000.00'),
(2, 'Большой термоконтейнер', 'Термоконтейнеры большие', 'Надежные термоконтейнеры большого объема для промышленного использования.', 1, 'therm-big (1).jpg', '[\"therm-big (1).jpg\", \"therm-big (2).jpg\", \"therm-big (3).jpg\", \"therm-big (4).jpg\", \"therm-big (5).jpg\", \"therm-big (6).jpg\", \"therm-big (7).jpg\"]', 'Большой термоконтейнер', 'Большие термоконтейнеры предназначены для промышленного использования и обеспечивают надежное хранение и транспортировку термочувствительных материалов в больших объемах. Они идеально подходят для фармацевтической, пищевой и химической промышленности. Конструкция контейнера обеспечивает высокую теплоизоляцию, прочность и легкость в обслуживании.', '15000.00'),
(3, 'Малый термоконтейнер', 'Термоконтейнеры малые', 'Компактные термоконтейнеры для средних и малых предприятий.', 1, 'therm-small (1).jpg', '[\"therm-small (1).jpg\", \"therm-small (3).jpg\", \"therm-small (4).jpg\", \"therm-small (5).jpg\", \"therm-small (6).jpg\", \"therm-small (7).jpg\"]', 'Малый термоконтейнер', 'Малые термоконтейнеры являются компактными и универсальными решениями для средних и малых предприятий. Они обеспечивают надежное хранение и транспортировку термочувствительных материалов в меньших объемах. Конструкция контейнера компактна, легка в обслуживании и соответствует высоким стандартам безопасности.', '15000.00'),
(4, 'Зарядное устройство', 'Зарядные устройства для аккумуляторных батарей', 'Эффективные зарядные устройства для различных типов аккумуляторных батарей.', 3, 'charge (2).jpg', '[\"charge (1).jpg\", \"charge (2).jpg\"]', 'Зарядное устройство', 'Зарядные устройства нашей компании разработаны для эффективной зарядки различных типов аккумуляторных батарей. Они обеспечивают быструю и безопасную зарядку, а также универсальны в использовании. Устройства проходят строгие тесты на качество и безопасность, гарантируя их долгосрочную эксплуатацию.', '7000.00'),
(5, 'Радиоприёмник', 'Радиоприёмник', 'Цифровой двух-канальный широкополосный радиоприёмник для радиомониторинга.', 4, 'radio (1).jpg', '[\"radio (1).jpg\", \"radio (2).jpg\"]', 'Радиоприёмник', 'Радиоприёмник нашей компании представляет собой цифровой двух-канальный широкополосный радиоприёмник, предназначенный для радиомониторинга. Он обладает высокой чувствительностью и многофункциональностью, что делает его идеальным для различных применений в сфере радиосвязи. Приёмник обеспечивает качественное приём сигнала и надежную эксплуатацию.', '8000.00');

-- --------------------------------------------------------

--
-- Структура таблицы `product_features`
--

CREATE TABLE `product_features` (
  `feature_id` int(11) NOT NULL,
  `product_id` int(11) DEFAULT NULL,
  `feature` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Дамп данных таблицы `product_features`
--

INSERT INTO `product_features` (`feature_id`, `product_id`, `feature`) VALUES
(6, 2, 'Высокая теплоизоляция'),
(7, 2, 'Прочная конструкция'),
(8, 2, 'Большая вместимость'),
(9, 2, 'Легкость в обслуживании'),
(10, 2, 'Соответствие стандартам безопасности'),
(11, 3, 'Компактная конструкция'),
(12, 3, 'Высокая теплоизоляция'),
(13, 3, 'Легкость в обслуживании'),
(14, 3, 'Соответствие стандартам безопасности'),
(15, 3, 'Универсальность в использовании'),
(16, 4, 'Быстрая зарядка'),
(17, 4, 'Универсальность в использовании'),
(18, 4, 'Надежная конструкция'),
(19, 4, 'Легкость в обслуживании'),
(20, 4, 'Соответствие стандартам безопасности'),
(21, 5, 'Высокая чувствительность'),
(22, 5, 'Многофункциональность'),
(23, 5, 'Цифровой двух-канальный широкополосный приём'),
(24, 5, 'Надежная конструкция'),
(25, 5, 'Легкость в обслуживании'),
(32, 1, 'Высокая емкость11'),
(33, 1, 'Длительная автономная работа'),
(34, 1, 'Легкость в обслуживании'),
(35, 1, 'Соответствие стандартам безопасности'),
(36, 1, 'Надежная конструкция');

-- --------------------------------------------------------

--
-- Структура таблицы `product_specs`
--

CREATE TABLE `product_specs` (
  `spec_id` int(11) NOT NULL,
  `product_id` int(11) DEFAULT NULL,
  `parameter` varchar(255) NOT NULL,
  `value` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Дамп данных таблицы `product_specs`
--

INSERT INTO `product_specs` (`spec_id`, `product_id`, `parameter`, `value`) VALUES
(6, 2, 'Объем', '500 литров'),
(7, 2, 'Материал корпуса', 'Высокопрочный пластик'),
(8, 2, 'Изоляционный материал', 'Полиуретановая пена'),
(9, 2, 'Температурный диапазон', 'от -20°C до +50°C'),
(10, 2, 'Время сохранения температуры', 'до 72 часов'),
(11, 2, 'Габариты (ДxШxВ)', '120 x 100 x 120 см'),
(12, 2, 'Вес (пустой)', '50 кг'),
(13, 3, 'Объем', '100 литров'),
(14, 3, 'Материал корпуса', 'Высокопрочный пластик'),
(15, 3, 'Изоляционный материал', 'Полиуретановая пена'),
(16, 3, 'Температурный диапазон', 'от -20°C до +50°C'),
(17, 3, 'Время сохранения температуры', 'до 48 часов'),
(18, 3, 'Габариты (ДxШxВ)', '60 x 50 x 60 см'),
(19, 3, 'Вес (пустой)', '15 кг'),
(20, 4, 'Максимальный ток зарядки', '5 А'),
(21, 4, 'Напряжение зарядки', '12 В'),
(22, 4, 'Вес', '0.5 кг'),
(23, 4, 'Габариты (ДxШxВ)', '100 x 50 x 20 мм'),
(24, 4, 'Соответствие стандартам', 'CE, RoHS'),
(25, 5, 'Частотный диапазон', '20 МГц - 1 ГГц'),
(26, 5, 'Чувствительность', '0.5 мкВ'),
(27, 5, 'Каналы', '2'),
(28, 5, 'Вес', '0.2 кг'),
(29, 5, 'Габариты (ДxШxВ)', '100 x 50 x 20 мм');

-- --------------------------------------------------------

--
-- Структура таблицы `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `username` varchar(50) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Дамп данных таблицы `users`
--

INSERT INTO `users` (`id`, `username`, `email`, `password`) VALUES
(1, 'akim', 'akim@fd', '$2y$10$AYKg7q0kzzHN3gXQPQqqR.004awJa8VDN8egCIBczS0AbGdAg96.O'),
(2, 'akim1', 'akim@fd1', '$2y$10$XEOuJPvU0dgnI4.BuIVT9.hLklsWTpUajn17SiYyPtBWgUk/csX7O'),
(3, 'XgjlWNviPtEr', 'xubodijaku736@gmail.com', '$2y$10$X/re9VRWq7pOwK6tty50mOaZIlBYCUWuf96cf1dX4PwqrlbeMuZhO'),
(4, 'SHornWJXaGakSwa', 'oziqijujeduz15@gmail.com', '$2y$10$sBm.WDK7e8ERdGVbHkp22O3OrisNxm4oSk.PEOAJiuyAFHUYBcBeq'),
(5, 'sMdSCyiGNGqGy', 'carenbauerbostwic@yahoo.com', '$2y$10$jVxMR3HdPxE1OxTe9QuiX.StiwOwQzABGV32WaRqiiaZNkkYtDPi2'),
(6, 'AQvhLHeHPlHS', 'nxbvigodqahspb@yahoo.com', '$2y$10$WvwAr7Gy6P3fYIGYqoN9xudQ.ADTfn5oiDB7y5RCU7f5uWSTHwSCK'),
(7, 'iQrJkxpUGmwf', 'ehipijido02@gmail.com', '$2y$10$Uqy5C52xOCybdxDoWbjQLeLiPRGDJVQyICMUs01AagbtQZUNafLnO'),
(8, 'UkVYgqnhZ', 'eidmbleibinger@yahoo.com', '$2y$10$S8FXNnSZOmP3/rDm2.L0h.7sjhLY1Tn1H18h8bdCZoOmPd4bi2S3C'),
(9, 'ALsSFpVfzUs', 'niobuqajreouj@yahoo.com', '$2y$10$o7iZsJavmySZr.nNgtGeFeGcp4C1qE91NLaWTlhckuGhtvd22B7oa'),
(10, 'IJIJceJvpJ', 'urizukom48@gmail.com', '$2y$10$3VB2r8DgtT2gX/Jf81xVz.4EAwbBY1ZB1MuQggipHo80JAFH7ZMyq'),
(11, 'XYUvDquFjdq', 'cl3tk7ho5gm5pcpbr@yahoo.com', '$2y$10$hLAKxJtHAshuq0p7Fc16suRVPJctuM7bbTFrYHa3bslnd.MZ1CRRa'),
(12, 'VMEgVgjqXaqdQqZ', 'dqib0huq5o@yahoo.com', '$2y$10$v5CpNMKqh1WbPwP3GoFCPuOBYjwF8oFmCBPPptY2ZP2Mn2BSZQ81y'),
(13, 'rMcHaXwGzRZ', 'eyoqexofewup93@gmail.com', '$2y$10$BXtS1zDXGESHXBYx5C0nkulRsVEVePHuRR97WKMNt.nF.TAgyKxcW'),
(14, 'NKlZCSeswCOnoeL', 'adaheqecet70@gmail.com', '$2y$10$F1op6B7pMuXwyySbQW7CRu.DbCyd8WbYkHZ8qS6UjAdJeAvNzzkJC'),
(15, 'RbMWfMUdnV', 'eitencarll@yahoo.com', '$2y$10$ovYeJafrLF0DPjRfZyRga.i.RSJGIVYByilDQEnJn7SD3OLofK.Lu'),
(16, 'aInVrTjwrBnaC', 'gufeducugabo35@gmail.com', '$2y$10$AJMcFF7gvEf7ETkKh323t.S1USFeiAiBEklREz/R3tgx9iImvfuoa'),
(17, 'rbuONnEbEMcKLZa', 'umunuworox81@gmail.com', '$2y$10$pI8OkdTuWEv3beDxZCATGuje.hsD.MaGQOvx2FIdqWJtEYhi4PlC.'),
(18, 'NdCDOoMyuQ', 'dgqmqxk7zl@yahoo.com', '$2y$10$/.q5pU2/lcLogkzaBfRoXOCTyOX4TZGKuQFsfVcUgW1wX2j1Tihjq'),
(19, 'bQCVdJLEtzHbgnY', 'amgwbiarftxterhsg@yahoo.com', '$2y$10$EPM/2QZNNssHTbGJGzd/Q.Ms272eSQ3nhC7ihMYxJ.mWfsfpJugLG'),
(20, 'UWINtZqwWUJcy', 'ftncbnpx2n0y@yahoo.com', '$2y$10$CbjALV/uLMzw/5gbJullreMnaNc0ocq2zZJw4CvxHoxBuzddSAvdm'),
(21, 'cdqeiNdouuh', 'pbrmgswitdbgila@yahoo.com', '$2y$10$hjDyrRwGAs2pLxDjJbcOHe9spaBhLsNZQRRNY368e0mP5.ARW8Oby'),
(22, 'kfSRABWwy', 'fqc2d6gge@yahoo.com', '$2y$10$U.zizlPwEn3NS7QFDuZw8ONMBVWj0SVwfvcpvMcKMCtypTYGm/qbi');

--
-- Индексы сохранённых таблиц
--

--
-- Индексы таблицы `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`category_id`);

--
-- Индексы таблицы `customers`
--
ALTER TABLE `customers`
  ADD PRIMARY KEY (`customer_id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- Индексы таблицы `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`order_id`),
  ADD KEY `customer_id` (`customer_id`),
  ADD KEY `payment_method_id` (`payment_method_id`),
  ADD KEY `orders_ibfk_3` (`product_id`);

--
-- Индексы таблицы `order_items`
--
ALTER TABLE `order_items`
  ADD PRIMARY KEY (`order_item_id`),
  ADD KEY `order_id` (`order_id`),
  ADD KEY `product_id` (`product_id`);

--
-- Индексы таблицы `payment_methods`
--
ALTER TABLE `payment_methods`
  ADD PRIMARY KEY (`payment_method_id`);

--
-- Индексы таблицы `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`product_id`),
  ADD KEY `category_id` (`category_id`);

--
-- Индексы таблицы `product_features`
--
ALTER TABLE `product_features`
  ADD PRIMARY KEY (`feature_id`),
  ADD KEY `product_id` (`product_id`);

--
-- Индексы таблицы `product_specs`
--
ALTER TABLE `product_specs`
  ADD PRIMARY KEY (`spec_id`),
  ADD KEY `product_id` (`product_id`);

--
-- Индексы таблицы `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- AUTO_INCREMENT для сохранённых таблиц
--

--
-- AUTO_INCREMENT для таблицы `categories`
--
ALTER TABLE `categories`
  MODIFY `category_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT для таблицы `customers`
--
ALTER TABLE `customers`
  MODIFY `customer_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT для таблицы `orders`
--
ALTER TABLE `orders`
  MODIFY `order_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT для таблицы `order_items`
--
ALTER TABLE `order_items`
  MODIFY `order_item_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT для таблицы `payment_methods`
--
ALTER TABLE `payment_methods`
  MODIFY `payment_method_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT для таблицы `products`
--
ALTER TABLE `products`
  MODIFY `product_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT для таблицы `product_features`
--
ALTER TABLE `product_features`
  MODIFY `feature_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=37;

--
-- AUTO_INCREMENT для таблицы `product_specs`
--
ALTER TABLE `product_specs`
  MODIFY `spec_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=30;

--
-- AUTO_INCREMENT для таблицы `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;

--
-- Ограничения внешнего ключа сохраненных таблиц
--

--
-- Ограничения внешнего ключа таблицы `orders`
--
ALTER TABLE `orders`
  ADD CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`customer_id`),
  ADD CONSTRAINT `orders_ibfk_2` FOREIGN KEY (`payment_method_id`) REFERENCES `payment_methods` (`payment_method_id`),
  ADD CONSTRAINT `orders_ibfk_3` FOREIGN KEY (`product_id`) REFERENCES `products` (`product_id`);

--
-- Ограничения внешнего ключа таблицы `order_items`
--
ALTER TABLE `order_items`
  ADD CONSTRAINT `order_items_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `orders` (`order_id`),
  ADD CONSTRAINT `order_items_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `products` (`product_id`);

--
-- Ограничения внешнего ключа таблицы `products`
--
ALTER TABLE `products`
  ADD CONSTRAINT `products_ibfk_1` FOREIGN KEY (`category_id`) REFERENCES `categories` (`category_id`);

--
-- Ограничения внешнего ключа таблицы `product_features`
--
ALTER TABLE `product_features`
  ADD CONSTRAINT `product_features_ibfk_1` FOREIGN KEY (`product_id`) REFERENCES `products` (`product_id`);

--
-- Ограничения внешнего ключа таблицы `product_specs`
--
ALTER TABLE `product_specs`
  ADD CONSTRAINT `product_specs_ibfk_1` FOREIGN KEY (`product_id`) REFERENCES `products` (`product_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
