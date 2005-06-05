#!/usr/bin/perl -w

# Support method testing for Params::Coerce

use strict;
use lib ();
use UNIVERSAL 'isa';
use File::Spec::Functions ':ALL';
BEGIN {
	$| = 1;
	unless ( $ENV{HARNESS_ACTIVE} ) {
		require FindBin;
		chdir ($FindBin::Bin = $FindBin::Bin); # Avoid a warning
		lib->import( catdir( updir(), updir(), 'modules') );
	}
}

use Test::More tests => 5;
use Params::Coerce ();





#####################################################################
# Begin testing support methods

# Test _loaded
ok(   Params::Coerce::_loaded('Params::Coerce'), '_loaded returns true for Params::Coerce' );
ok( ! Params::Coerce::_loaded('Params::Coerce::Bad'), '_loaded returns false for Params::Coerce::Bad' );

# Test _function_exists
ok(   Params::Coerce::_function_exists('Params::Coerce', '_function_exists'), '_function_exists sees itself' );
ok( ! Params::Coerce::_function_exists('Foo', 'bar'), '_function_exists doesn\' see non-existant function' );
ok( ! Params::Coerce::_function_exists('Params::Coerce', 'VERSION'),
	'_function_exists does not return true for other variable types' );

exit(0);
