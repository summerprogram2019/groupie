<?php
define('DB_HOST', 'localhost');
define('DB_USER', 'root');
define('DB_PWD', 'b73ae1779473c0ff');
define('DB_CHARSET', 'UTF8');
define('DB_DBNAME', 'dumplings');
function connect ()
{
    //连接mysql
    $link = mysqli_connect(DB_HOST, DB_USER, DB_PWD, DB_DBNAME) or die ('Failure of database connection<br/>ERROR ' . mysqi_errno() . ':' . mysqli_error());
    //设置字符集
    mysqli_set_charset($link, DB_CHARSET);
    return $link;
}
    ?>
