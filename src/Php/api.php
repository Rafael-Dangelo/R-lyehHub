<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Headers: *");
header("Content-Type: application/json");

$host = "localhost";
$user = "root";
$password = "";
$dbname = "ficha_manager";

$conn = mysqli_connect($host, $user, $password, $dbname);

if (!$conn) {
    echo json_encode(["erro" => "Falha na conexão"]);
    exit;
}

echo json_encode(["mensagem" => "Conectado ao PHP com sucesso!"]);
?>
