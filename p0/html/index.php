<?php header("Cache-Control: no-cache, must-revalidate");?>
<!DOCTYPE html>
<html>
<head>
    <title>GEI AISI</title>
    <link href="css/bootstrap.min.css" rel="stylesheet">
    <script type="text/javascript">
	function init() {
	    var name = "Oscar Olveira Miniño";
	    document.getElementById("myName").innerHTML = name;
	}
        function getURL() {
	    document.write(window.location.href);
        }
       	function getTIME() {
	    document.getElementById("current_date").innerHTML = Date();
    	}
    </script>
</head>
<body onload="init()">
    <div class="container" style="text-align: center;"><div class="jumbotron">
    <p><img src="img/udc.png" style="max-width: 300px; width: auto;"></p>
    <p><u>GEI AISI: 2024/2025</u></p>
    <p><img src="img/apache.png" style="max-width: 200px; width: auto;"></img></p>
    <p>Páxina web de <span id="myName"></span></p>
    <p><script>getURL();</script></p>
    <h4><div id="current_date"><script>getTIME();</script></div></h4>
    <?php include('get-info.php');?></div></div>
</body>
</html>
