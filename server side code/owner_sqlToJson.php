<?php
    require("connect.php");
    
    $db = mysqli_connect($dbServer, $dbUser, $dbPassword) or die("Could not connect to mysql");
    mysqli_select_db($db, $dbName) or die("Could not select Database");
    
    $query = "select * from Owner";
    
    $result = mysqli_query($db,$query);
    
    while ($row = mysqli_fetch_array($result)){
        $row_set[] = $row;
    }
    
    echo trim(json_encode($row_set));
    mysqli_close($db);
    
    
?>