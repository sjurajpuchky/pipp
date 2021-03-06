# Copyright (C) 2008-2009, The Perl Foundation.

=head1 NAME

t/php/control_flow.t - tests for Pipp

=head1 SYNOPSIS

    perl t/harness t/php/control_flow.t

=head1 DESCRIPTION

Test control flow, that is C<if>, C<while>, C<for> and C<switch>.

=cut

# pragmata
use strict;
use warnings;
use FindBin;
use lib "$FindBin::Bin/../../../../lib", "$FindBin::Bin/../../lib";

use Pipp::Test  tests => 23;

language_output_is( 'Pipp', <<'CODE', <<'OUT', 'if, one statement in block' );
<?php
if (1)
{
  echo "Hi\n";
}
?>
CODE
Hi
OUT

language_output_is( 'Pipp', <<'CODE', <<'OUT', 'if, no statements in block' );
<?php
if (1)
{
}
echo "Hi\n";
?>
CODE
Hi
OUT

language_output_is( 'Pipp', <<'CODE', <<'OUT', 'if, two statements in block' );
<?php
if (1)
{
  echo "Hi";
  echo "\n";
}
?>
CODE
Hi
OUT

language_output_is( 'Pipp', <<'CODE', <<'OUT', 'if/else taking if-branch' );
<?php
if (1)
{
  echo "if block\n";
}
else
{
  echo "else block\n";
}
?>
CODE
if block
OUT

language_output_is( 'Pipp', <<'CODE', <<'OUT', 'if/else taking else-branch' );
<?php
if (0)
{
  echo "if block\n";
}
else
{
  echo "else block\n";
}
?>
CODE
else block
OUT

language_output_is( 'Pipp', <<'CODE', <<'OUT', 'if/elseif/else taking elseif-branch' );
<?php
$x = 1;
if($x ==0)
{
  echo "if block\n";
}
elseif($x == 1)
{
  echo "elseif block\n";
}
else
{
  echo "else block\n";
}
CODE
elseif block
OUT

language_output_is( 'Pipp', <<'CODE', <<'OUT' . q{  }, 'positive int' );
<?php
if (1) {
  ?>
    Condition is true.
  <?php
}
?>
CODE
    Condition is true.
OUT

language_output_is( 'Pipp', <<'CODE', <<'OUT', 'zero' );
<?php
if (0) {
  ?>
    'Condition is true' does not apply.
  <?php
}
?>
Condition is false.
CODE
Condition is false.
OUT

language_output_is( 'Pipp', <<'CODE', <<'OUT', 'string' );
<?php
if ( 'false' ) {
?>
The string 'false' is true.
<?php
}
?>
CODE
The string 'false' is true.
OUT

language_output_is( 'Pipp', <<'CODE', <<'OUT', 'string' );
<?php
if ( 'vrai' ) {
?>
The string 'vrai' is true.
<?php
}
else
{
?>
The string 'vrai' is false.
<?php
}
?>
CODE
The string 'vrai' is true.
OUT


language_output_is( 'Pipp', <<'CODE', <<'OUT', 'string' );
<?php
if ( 0 ) {
?>
The integer 0 is true.
<?php
}
else
{
?>
The integer 0 is false.
<?php
}
?>
CODE
The integer 0 is false.
OUT

language_output_is( 'Pipp', <<'CODE', <<'OUT', 'while loop' );
<?php

$count = 0;
while ( $count < 10 ) { $count++; echo "round $count\n"; }
CODE
round 1
round 2
round 3
round 4
round 5
round 6
round 7
round 8
round 9
round 10
OUT

language_output_is( 'Pipp', <<'CODE', <<'OUT', 'while with negated expression' );
<?php

$count = 0;
while ( ! ( $count >= 10 ) ) { $count++; echo "round $count\n"; }
CODE
round 1
round 2
round 3
round 4
round 5
round 6
round 7
round 8
round 9
round 10
OUT

language_output_is('Pipp', <<'CODE', <<'OUT', 'do-while loop');
<?php

$count = 0;
do { echo "round $count\n"; $count++; } while ($count <= 10);
CODE
round 0
round 1
round 2
round 3
round 4
round 5
round 6
round 7
round 8
round 9
round 10
OUT

language_output_is( 'Pipp', <<'CODE', <<'OUT', 'do-while with negated expression');
<?php

$count = 0;
do { $count++; echo "round $count\n"; } while (!($count >= 10));
CODE
round 1
round 2
round 3
round 4
round 5
round 6
round 7
round 8
round 9
round 10
OUT

language_output_is( 'Pipp', <<'CODE', <<'OUT', 'classic for-loop' );
<?php

$count = 0;
for ( $count = 0; $count < 10; $count++ ) { echo "round $count\n"; }
CODE
round 0
round 1
round 2
round 3
round 4
round 5
round 6
round 7
round 8
round 9
OUT

language_output_is( 'Pipp', <<'CODE', <<'OUT', 'for-loop with HTML-block' );
<?php

$count = 0;
for ( $count = 0; $count < 10; $count++ ) { ?>round <?php echo $count
?>

<?php } ?>
CODE
round 0
round 1
round 2
round 3
round 4
round 5
round 6
round 7
round 8
round 9
OUT

language_output_is( 'Pipp', <<'CODE', <<'OUT', 'another for-loop' );
<?php for ( $count = 0; $count < 10; $count++ ) { ?>round <?php echo $count ?>

<?php } ?>
CODE
round 0
round 1
round 2
round 3
round 4
round 5
round 6
round 7
round 8
round 9
OUT

language_output_is( 'Pipp', <<'CODE', '', 'switch, no case' );
<?php

switch (22) {
}

?>
CODE

language_output_is( 'Pipp', <<'CODE', '', 'switch, single non-matching case' );
<?php

switch (22) {
    case 11:
       echo 'no match';
       break;
}

?>
CODE

language_output_is( 'Pipp', <<'CODE', 'match', 'switch, single matching case' );
<?php

switch (22) {
    case 22:
       echo 'match';
       break;
}

?>
CODE

language_output_is( 'Pipp', <<'CODE', 'default', 'switch, default case' );
<?php

switch (22) {
    case 22:
       echo 'default';
       break;
}

?>
CODE

language_output_is( 'Pipp', <<'CODE', 'twentytwo', 'switch, two cases' );
<?php

switch (22) {
    case 21:
       echo 'twentyone';
       break;
    case 22:
       echo 'twentytwo';
       break;
}

?>
CODE

# Local Variables:
#   mode: cperl
#   cperl-indent-level: 4
#   fill-column: 100
# End:
# vim: expandtab shiftwidth=4:
