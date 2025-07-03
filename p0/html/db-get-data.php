<?php
   $database="oom2425";
   
  // Set address book variables
  isset($_REQUEST['mode']) ? $mode=$_REQUEST['mode'] : $mode="";
  isset($_REQUEST['id']) ? $id=$_REQUEST['id'] : $id="";
  isset($_REQUEST['lastname']) ? $lastname=$_REQUEST['lastname'] : $lastname="";
  isset($_REQUEST['firstname']) ? $firstname=$_REQUEST['firstname'] : $firstname="";
  isset($_REQUEST['phone']) ? $phone=$_REQUEST['phone'] : $phone="";
  isset($_REQUEST['email']) ? $email=$_REQUEST['email'] : $email="";

  try {
     // Connect to the database
     $connect=mysqli_connect("192.168.56.11:3306", "root", "root", $database);
     mysqli_select_db($connect, $database);
     echo "<p style='color: green;'>DB connection: OK ($database)</p>";
  } catch(Exception $e) {
     echo "<p style='color: red;'>DB connection: FAILED (", $e->getMessage(), ")</p>";
     return;
  }
      
if ( $mode=="add")
 {
 Print '<h4 style="color: blue;">Add Contact</h4>
 <p>
 <form action=';
 echo $_SERVER['PHP_SELF'];
 Print '
 method=post>
 <table style="margin: 0px auto;">
 <tr><td>Last Name:</td><td><input type="text" name="lastname" /></td></tr>
 <tr><td>First Name:</td><td><input type="text" name="firstname" /></td></tr>
 <tr><td>Phone:</td><td><input type="text" name="phone" /></td></tr>
 <tr><td>Email:</td><td><input type="text" name="email" /></td></tr>
 <tr><td colspan="2" align="center"><input type="submit" /></td></tr>
 <input type=hidden name=mode value=added>
 </table>
 </form> <p>';
 }

 if ( $mode=="added")
 {
 mysqli_query($connect, "INSERT INTO address (lastname, firstname, phone, email) VALUES ('$lastname', '$firstname', '$phone', '$email')");
 Print '<h4 style="color: blue;">Data added!</h4>';
 }

if ( $mode=="edit")
 {
 Print '<h4 style="color: blue;">Edit Contact</h4>
 <p>
 <form action=';
 echo $_SERVER['PHP_SELF'];
 Print '
 method=post>
 <table style="margin: 0px auto;">
 <tr><td>Last name:</td><td><input type="text" value="';
 Print $lastname;
 print '" name="lastname" /></td></tr>
 <tr><td>First name:</td><td><input type="text" value="';
 Print $firstname;
 print '" name="firstname" /></td></tr>
 <tr><td>Phone:</td><td><input type="text" value="';
 Print $phone;
 print '" name="phone" /></td></tr>
 <tr><td>Email:</td><td><input type="text" value="';
 Print $email;
 print '" name="email" /></td></tr>
 <tr><td colspan="3" align="center"><input type="submit" /></td></tr>
 <input type=hidden name=mode value=edited>
 <input type=hidden name=id value=';
 Print $id;
 print '>
 </table>
 </form> <p>';
 }

 if ( $mode=="edited")
 {
 mysqli_query($connect, "UPDATE address SET lastname = '$lastname', firstname = '$firstname', phone = '$phone', email = '$email' WHERE id = $id");
 Print '<h4 style="color: blue;">Data updated!</h4>';
 }

if ( $mode=="remove")
 {
 mysqli_query($connect, "DELETE FROM address where id=$id");
 Print '<h4 style="color: blue;">Entry has been removed!</h4>';
 }

 $data = mysqli_query($connect, "SELECT * FROM address ORDER BY lastname ASC")
 or die(mysqli_error($connect));
 Print "<table border cellpadding=3 style='margin: 0px auto;'>";
 Print "<tr><th width=100>Last name</th> " .
   "<th width=100>First name</th> " .
   "<th width=100>Phone</th> " .
   "<th width=200>Email</th> " .
   "<th width=100 colspan=3>Admin</th></tr>";
 Print "<td colspan=6 align=right> " .
   "<a href=" .$_SERVER['PHP_SELF']. "?mode=add>Add Contact</a></td>";
 while($info = mysqli_fetch_array( $data ))
 {
 Print "<tr><td>".$info['lastname'] . "</td> ";
 Print "<td>".$info['firstname'] . "</td> ";
 Print "<td>".$info['phone'] . "</td> ";
 Print "<td> <a href=mailto:".$info['email'] . ">" .$info['email'] . "</a></td>";
 Print "<td><a href=" .$_SERVER['PHP_SELF']. "?id=" . $info['id'] ."&lastname=" . $info['lastname'] . "&firstname=" . $info['firstname'] . "&phone=" . $info['phone'] ."&email=" . $info['email'] . "&mode=edit>Edit</a></td>";
 Print "<td><a href=" .$_SERVER['PHP_SELF']. "?id=" . $info['id'] ."&mode=remove>Remove</a></td></tr>";
 }
 Print "</table>";
?>
