<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<title>Лабораторная PHP</title>
	<link rel="stylesheet" href="css/style.css">
	<meta name="viewport" content="width=device-width, initial-scale=1, minimum-scale=1" />
    <link rel="stylesheet" type="text/css" media="all" href="../css/cascade/production/full.min.css" />
    <link rel="stylesheet" type="text/css" media="all" href="../css/site.css" />
</head>
<body>
<div class="site-header">
    <div class="site-center">
        <div class="cell">
            <h3>Вариант 13, Продажа автомобилей, ПОИТ-61</h3>
            <a href="../index.html" class="">Перейти на главную</a>
        </div>
    </div>
</div>

<?php $root_cat = "http://localhost/"; ?>

<table cellspacing="0" cellpadding="0" class="border" style="border: none;">
	<tr>
		<th style="border: none;">Работа 1.1<br>[В разных файлах]</th>
		<th style="border: none;">Работа 1.2<br>[В одном файле]</th>
		<th style="border: none;">Работа 2<br>[Текстовые файлы]</th>
		<th style="border: none;">Работа 3<br>[База данных]</th>
	</tr>
	<tr>
		<td><a href=<?php echo $root_cat.'lab011/cars.php'?>>Автомобили</a></td>
		<td><a href=<?php echo $root_cat.'lab012/cars.php'?>>Автомобили</a></td>
		<td><a href=<?php echo $root_cat.'lab020/cars.php'?>>Автомобили</a></td>
		<td><a href=<?php echo $root_cat.'lab030/cars.php'?>>Автомобили</a></td>
	</tr>
	<tr>
		<td><a href=<?php echo $root_cat.'lab011/owners.php'?>>Владельцы</a></td>
		<td><a href=<?php echo $root_cat.'lab012/owners.php'?>>Владельцы</a></td>
		<td><a href=<?php echo $root_cat.'lab020/owners.php'?>>Владельцы</a></td>
		<td><a href=<?php echo $root_cat.'lab030/owners.php'?>>Владельцы</a></td>
	</tr>
	<tr>
		<td><a href=<?php echo $root_cat.'lab011/buyers.php'?>>Покупатели</a></td>
		<td><a href=<?php echo $root_cat.'lab012/buyers.php'?>>Покупатели</a></td>
		<td><a href=<?php echo $root_cat.'lab020/buyers.php'?>>Покупатели</a></td>
		<td><a href=<?php echo $root_cat.'lab030/buyers.php'?>>Покупатели</a></td>
	</tr>
</table>