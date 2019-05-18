<!DOCTYPE html>
<html>
<head>
    <?php
        $actPath = '';
        if (isset($_GET['filename'])) {
            $actPath = $_GET['filename'];
        }
    ?>
    <title><?=$actPath?></title>
    <meta charset="utf-8">
    <!--[if lt IE 9]><script src="tpl/js/html5.js"></script><![endif]-->
    <script src="tpl/js/project.js"></script>
    <link rel="stylesheet" type="text/css" href="tpl/css/style.css">
</head>
<body>
    <div class="wrapper">
        <header class="header">
            <nav>
                <div>
                    <ul class="menu">
                        <li <?=($actPath === 'news'?'class="active"':"")?>>
                            <a href="news">Новости</a>
                        </li>
                        <li <?=($actPath === 'products'?'class="active"':"")?>>
                            <a href="products">Продукция</a>
                        </li>
                        <?php if ($isAdmin) { ?>
                            <li <?=($actPath === 'products-type'?'class="active"':"")?>>
                                <a href="products-type">Типы продукции</a>
                            </li>
                        <?php } ?>
                        <li <?=($actPath === 'partners'?'class="active"':"")?>>
                            <a href="partners">Для партнёров</a>
                        </li>
                        <li <?=($actPath === 'vacancies'?'class="active"':"")?>>
                            <a href="vacancies">Вакансии</a>
                        </li>
                        <?php if ($isAdmin) { ?>
                            <li <?=($actPath === 'resume'?'class="active"':"")?>><a href="resume">Резюме</a></li>
                        <?php } ?>
                        <li <?=($actPath === 'about'?'class="active"':"")?>>
                            <a href="about">О компании</a>
                        </li>
                        <?php if ($isAdmin) { ?>
                            <li style="float: right;" <?=($actPath === 'logout'?'class="active"':"")?>><a href="logout">
                                    <img border="0" alt="login" src="tpl/images/logout.png" width="16" height="16">
                                </a></li>
                        <?php } else { ?>
                            <li style="float: right;" <?=($actPath === 'auth'?'class="active"':"")?>><a href="auth">
                                    <img border="0" alt="login" src="tpl/images/login.png" width="16" height="16">
                                </a></li>
                        <?php } ?>
                    </ul>
                </div>
            </nav>
        </header>
        <?php if (isset($_SESSION["errormsg"])) { ?>
            <div class="error"> <?= $_SESSION["errormsg"]; ?> </div>
            <?php unset($_SESSION["errormsg"]); ?>
        <?php } ?>
        <article class="content">