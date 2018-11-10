<?php
session_start();

include_once("./../models/ImagemDAO.php");
include_once("./../classes/Database.php");
include_once("./../classes/Imagem.php");


$db = new Database();
$imagem = new Imagem();
$imagemDAO = new ImagemDAO($db);

$imagem->setNome($_FILES['arquivo']['name']);
$imagem->setConteudo($_FILES['arquivo']['tmp_name']);
$imagem->setArquivo($_FILES['arquivo']);
$imagem->setEventos_id($_GET['id']);
$imagem->setUsuarioId($_SESSION['id']);

$imagemDAO->uploadImage($imagem, $imagemDAO, $_GET['id']);
