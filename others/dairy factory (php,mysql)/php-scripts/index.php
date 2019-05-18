<?php

// запуск сессии
session_start();

// подключение конфигурационного файла
require_once 'config/config.php';

// подключение класса работы с БД
require_once 'db/db.php';


$isAdmin = isset($_SESSION['$isAdmin']);

include('tpl/header.tpl.php');

if (isset($_GET['filename'])) {

    $filename = $_GET['filename'];
    switch ($filename) {
        case 'news':
            require('inc/news/news.php');
            include('tpl/tpl-news/news.tpl.php');
            if ($isAdmin) {
                include('tpl/tpl-news/news-add.tpl.php');
            }
            break;
        case 'news-add':
            if ($isAdmin) {
                require('inc/news/news-add.php');
            } else {
                include('tpl/auth.tpl.php');
            }
            break;
        case 'news-delete':
            if ($isAdmin) {
                require('inc/news/news-delete.php');
            } else {
                include('tpl/auth.tpl.php');
            }
            break;
        case 'auth':
            include('tpl/auth.tpl.php');
            break;
        case 'authorization':
            require('inc/authorization.php');
            break;
        case 'logout':
            session_destroy();
            header('Location: '.'news');
            break;
        case 'products':
            require('inc/products/products.php');
            include('tpl/tpl-products/products.tpl.php');
            if ($isAdmin) {
                include('tpl/tpl-products/products-add.tpl.php');
            }
            break;
        case 'products-add':
            if ($isAdmin) {
                require('inc/products/products-add.php');
            } else {
                include('tpl/auth.tpl.php');
            }
            break;
        case 'products-delete':
            if ($isAdmin) {
                require('inc/products/products-delete.php');
            } else {
                include('tpl/auth.tpl.php');
            }
            break;
        case 'products-type':
            if ($isAdmin) {
                require('inc/products-type/products-type.php');
                include('tpl/tpl-products-type/products-type.tpl.php');
                include('tpl/tpl-products-type/products-type-add.tpl.php');
            } else {
                include('tpl/auth.tpl.php');
            }
            break;
        case 'products-type-add':
            if ($isAdmin) {
                require('inc/products-type/products-type-add.php');
            } else {
                include('tpl/auth.tpl.php');
            }
            break;
        case 'products-type-delete':
            if ($isAdmin) {
                require('inc/products-type/products-type-delete.php');
            } else {
                include('tpl/auth.tpl.php');
            }
            break;
        case 'vacancies':
            require('inc/vacancies/vacancies.php');
            include('tpl/tpl-vacancies/vacancies.tpl.php');
            if ($isAdmin) {
                include('tpl/tpl-vacancies/vacancies-add.tpl.php');
            } else {
                include('tpl/tpl-resume/resume-add.tpl.php');
            }
            break;
        case 'vacancies-add':
            if ($isAdmin) {
                require('inc/vacancies/vacancies-add.php');
            } else {
                include('tpl/auth.tpl.php');
            }
            break;
        case 'vacancies-delete':
            if ($isAdmin) {
                require('inc/vacancies/vacancies-delete.php');
            } else {
                include('tpl/auth.tpl.php');
            }
            break;
        case 'resume':
            if ($isAdmin) {
                require('inc/resume/resume.php');
                include('tpl/tpl-resume/resume.tpl.php');
            }
            else {
                include('tpl/auth.tpl.php');
            }
            break;
        case 'resume-add':
            require('inc/resume/resume-add.php');
            break;
        case 'resume-delete':
            if ($isAdmin) {
                require('inc/resume/resume-delete.php');
            } else {
                include('tpl/auth.tpl.php');
            }
            break;
        case 'about':
            require('inc/about/about.php');
            if ($isAdmin) {
                include('tpl/tpl-about/about-edit.tpl.php');
            } else {
                include('tpl/tpl-about/about.tpl.php');
            }
            break;
        case 'about-edit':
            if ($isAdmin) {
                require('inc/about/about-edit.php');
            } else {
                include('tpl/auth.tpl.php');
            }
            break;
        case 'partners':
            require('inc/partners/partners-info.php');
            include('tpl/tpl-partners/partners-info.tpl.php');
            if ($isAdmin) {
                include('tpl/tpl-partners/partners-info-add.tpl.php');
            }
            break;
        case 'partners-add':
            if ($isAdmin) {
                require('inc/partners/partners-info-add.php');
            } else {
                include('tpl/auth.tpl.php');
            }
            break;
        case 'partners-delete':
            if ($isAdmin) {
                require('inc/partners/partners-info-delete.php');
            } else {
                include('tpl/auth.tpl.php');
            }
            break;
        default:
            require('inc/news/news.php');
            include('tpl/tpl-news/news.tpl.php');
            if ($isAdmin) {
                include('tpl/tpl-news/news-add.tpl.php');
            }
            break;
    }
} else {
    require('inc/news/news.php');
    include('tpl/tpl-news/news.tpl.php');
    if ($isAdmin) {
        include('tpl/tpl-news/news-add.tpl.php');
    }
}

include('tpl/footer.tpl.php');
