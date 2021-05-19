<?php
$servername = "localhost";
$username   = "hubbuddi_269509myshopadmin";
$password   = "h&LP]Z*xGcV4";
$dbname     = "hubbuddi_269509_myshopdb";

$conn = new mysqli($servername, $username, $password, $dbname);
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}
?>