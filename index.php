<?php include('header.php'); ?>

<?php if ( is_numeric($_GET["uoasa"])) echo "<h3>UOASA" . $_GET["uoasa"] . "</h3>";?>

<table class="table table-striped table-bordered table-condensed table-responsive table-hover tablesorter">
	<thead>
		<tr>
			<th><?php if ( is_numeric($_GET["uoasa"])) echo "Problem"; else echo "User"; ?></th>
			<th>Score</th>
		</tr>
	</thead>
	<tbody>
		<?php
			$output = array();
			$cmd = '/home/uoasa05/public_html/ps5/autograder.bash ';
			if ( is_numeric($_GET["uoasa"]) && ($_GET["uoasa"] < 41) ){
				$cmd .= "uoasa" . $_GET["uoasa"];
			}
			//echo $cmd;
			exec($cmd,$output);
			foreach ($output as $score){
				$tuple = split(" ", $score);
				if (empty($_GET["uoasa"]))
					echo "<tr><td><a href='?uoasa=" . substr($tuple[0],-2) . "'>" . $tuple[0] . "</a></td><td>" . $tuple[1] . "%</td></tr>";
				else
					echo "<tr><td><a target='_blank' href='ps5.pdf'>" . $tuple[0] . "</a></td><td>" . $tuple[1] . "</td></tr>";
			}
		?>
	</tbody>
</table>

<script>
	$(function() {
		$('.table').tablesorter();
		console.log("table sorter added");
	});
</script>

<?php include('footer.php'); ?>