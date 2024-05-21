<?php
function connection($email, $password)
{
    try {
        // Connection à la base de donnée
        $bdd = new PDO(
            'mysql:host=localhost;dbname=NewWorldDb;charset=utf8',
            'root',
            'kimiko'
        );
        // Construction de la requête 
        $requete = "SELECT * FROM user where email='$email';";
        // Envoi de la requête 
        $resultats = $bdd->query($requete);


        // Création d'un tableau vide
        $users = array();
        while ($row = $resultats->fetch(PDO::FETCH_ASSOC)) {
            $users[] = $row;
        }

        foreach ($users as $user) {
            $hash = password_hash($password, PASSWORD_BCRYPT);
            // On vérifie si le mot de passe est correct
            if (password_verify($user['password'], $hash)) {
                // On retourne les informations de l'utilisateur
                echo $user['password'];
                return $user;
            }
        }
        return false;
    } catch (\Throwable $th) {
        echo "Error: " . $th->getMessage();
    }
}

connection("admin@admin.com", "admin");
