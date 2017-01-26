<?php
include 'config.php';
include 'opendb.php';

$query  = 'CREATE DATABASE phpcake';
$result = mysql_query($query);

mysql_select_db('phpcake') or die('Cannot select database'); 

$query = 'CREATE TABLE contact( '.
         'cid INT NOT NULL AUTO_INCREMENT, '.
         'cname VARCHAR(20) NOT NULL, '.
         'cemail VARCHAR(50) NOT NULL, '.
         'csubject VARCHAR(30) NOT NULL, '.
         'cmessage TEXT NOT NULL, '.
         'PRIMARY KEY(cid))';

$result = mysql_query($query);

include 'closedb.php';
?> 
