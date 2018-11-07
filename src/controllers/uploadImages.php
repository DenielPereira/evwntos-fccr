<?php
session_start();

ini_set( 'display_errors', true );
error_reporting( E_ALL );

include_once("./../models/ImagemDAO.php");
include_once("./../classes/Database.php");
include_once("./../classes/Imagem.php");


$db = new Database();
$imagem = new Imagem();
$imagemDAO = new ImagemDAO($db);

$lastId = $db->lastInsertId();

$imagem->setNome($_FILES['arquivo']['name']);
$imagem->setConteudo($_FILES['arquivo']);
$imagem->setFotosID($lastId);
$imagem->setEventos_id($_GET['id']);
$imagem->setUsuarioId($_SESSION['id']);

$imagemDAO->uploadImage($imagem);
