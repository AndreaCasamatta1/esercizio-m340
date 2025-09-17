<?php
// Connessione PDO al database
$DB_HOST = '10.10.20.11';   
$DB_NAME = 'multimacchina'; 
$DB_USER = 'user';          
$DB_PASS = 'pass';        

// Output testuale per verificare subito l'esito
header('Content-Type: text/plain');

try {
	// Apr la connessione con codifica utf8mb4 che legge tutti i caratteri e gestione errori tramite eccezioni
	$pdo = new PDO(
		"mysql:host=$DB_HOST;dbname=$DB_NAME;charset=utf8mb4",
		$DB_USER,
		$DB_PASS,
		[PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION]
	);
	echo "Connessione OK a $DB_HOST/$DB_NAME come $DB_USER\n";

} catch (PDOException $e) {
    http_response_code(500);
	echo "Errore DB: " . $e->getMessage() . "\n";
}
?>
