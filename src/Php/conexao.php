<?php
header("Content-Type: application/json; charset=UTF-8");

$host = "localhost";
$user = "root";
$password = "";
$dbname = "ficha_manager";

$conn = mysqli_connect($host, $user, $password, $dbname);

if (!$conn) {
    echo json_encode(["erro" => "Falha na conexão: " . mysqli_connect_error()]);
    exit;
}

echo json_encode(["status" => "Conectado com sucesso"]);
?>
