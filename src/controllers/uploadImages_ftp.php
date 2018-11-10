<?php
include_once("./../models/ImagemDAO.php");
include_once("./../classes/Database.php");
include_once("./../classes/Imagem.php");

$db = new Database();
$imagem = new Imagem();
$imagemDAO = new ImagemDAO($db);

  session_start();

  ini_set( 'display_errors', true );
  error_reporting( E_ALL );


    if(isset($_FILES['arquivo'])){
      $errors= array();
      $file_name = $_FILES['arquivo']['name'];
      $file_size = $_FILES['arquivo']['size'];
      $file_tmp = $_FILES['arquivo']['tmp_name'];
      $file_type = $_FILES['arquivo']['type'];
      $file_ext = strtolower(end(explode('.',$_FILES['arquivo']['name'])));  
        
      $evento = $_GET['id'];
      $usuario = $_SESSION['id'];
        
      $expensions = array("jpeg","jpg","png");

      $path = "../../upload/".$evento."/".$usuario;
        
      if (!file_exists($path)) {
        mkdir($path, 0777, true);
      }
  
      if(in_array($file_ext,$expensions)=== false){
          $errors[]="extension not allowed, please choose a JPEG or PNG file.";
      }
        
        if($file_size > 2097152) {
          $errors[]='File size must be excately 2 MB';
      } 
        
      
      if(empty($errors)==true) {
        
        $file_name = $file_name.$evento."-".$usuario;
        $file_path = $path."/".$file_name;
        
        if(file_exists($file_path)){
          echo "<script>alert('Uma imagem com este nome já foi cadastrada por você neste evento! Mude o nome da imagem.');</script>";
          echo "<script>window.location.href = './../../views/checkin.php?id=".$evento."';</script>";
        
        } else {
          $upload = move_uploaded_file($file_tmp,"../../upload/".$evento."/".$usuario."/".$file_name);
          echo "Success";
            
            if ($upload) {
              $imagemDAO->insertTable($file_path, $evento, $usuario);
          }
        }
      } else{
            print_r($errors);
      }
    }