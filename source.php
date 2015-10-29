<?php include('header.php'); ?>

<pre>
	<?php echo highlight_string(file_get_contents('autograder.bash')); ?>
</pre>

<pre>
	<?php echo highlight_string(file_get_contents('zzPCT.bash')); ?>
</pre>

<?php include('footer.php'); ?>