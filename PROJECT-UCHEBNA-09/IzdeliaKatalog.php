<!DOCTYPE html>
<html>
<head>
    <title>ООО "Тензор-РТ" - Каталог изделий</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" type="text/css" href="css/IzdeliaKatalog.css">
</head>
<body>
    <header>
        <p><img src="images/LOGO2.png" width="208" height="52" alt="Tenzor-RT Logo"></p>
    </header>
    
    <nav>
    <ul>
            <li><a href="index.php">Главная</a></li>
            <li><a href="IzdeliaKatalog.php">Изделия</a></li>
            <li><a href="login-user.html">войти</a></li>
            <li><a href="registr-user.html">зарегистрироваться</a></li>
            <li><a href="order-history.html">история заказов</a></li>
            <li><a href="basket.html">корзина</a></li>
        </ul>
    </nav>
    
    <main>
        <h2>Каталог изделий</h2>
        <p>Наша компания специализируется на разработке и изготовлении высококачественного промышленного оборудования. Ниже представлены основные категории нашей продукции.</p>

        <?php
        $apiFilePath = __DIR__ . '/admin-panel/api.php';
        if (file_exists($apiFilePath)) {
            require_once $apiFilePath;
        } else {
            echo "Файл api.php не найден.";
            exit;
        }

        $sql = "SELECT product_id, name, description, main_photo AS image FROM products";
        $result = executeQuery($sql);

        if ($result === false) {
            echo "Ошибка выполнения запроса";
            exit;
        }
        ?>

        <div class="product-grid">
            <?php
            while ($row = $result->fetch_assoc()) {
                ?>
                <div class="product-card">
                    <img src="/images/<?php echo htmlspecialchars($row['image']); ?>" alt="<?php echo htmlspecialchars($row['name']); ?>" width="280" height="200">
                    <div class="product-info">
                        <h3><?php echo htmlspecialchars($row['name']); ?></h3>
                        <p><?php echo htmlspecialchars($row['description']); ?></p>
                    </div>
                    <a href="/Izdelie<?php echo $row['product_id']; ?>.php" class="cta-button">Подробнее</a>
                </div>
            <?php } ?>
        </div>

        <?php
        // Закрываем соединение после использования
        $db->close();
        ?>

        <!-- Остальной контент -->
    </main>
    
    <footer>
        <p>© 2024 ООО "Тензор-РТ". Все права защищены.</p>
    </footer>

</body></html>
