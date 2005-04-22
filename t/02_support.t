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

use Test::More tests => 23;
use Params::Coerce ();





#####################################################################
# Begin testing support methods

# Test _method
is( Params::Coerce::_method(),           '',    '_method() returns correctly' );
is( Params::Coerce::_method(undef),      '',    '_method(undef) returns correctly' );
is( Params::Coerce::_method(1),          '',    '_method(1) returns correctly' );
is( Params::Coerce::_method([]),         '',    '_method([]) returns correctly' );
is( Params::Coerce::_method(' '),        '',    '_method(" ") returns correctly' );
is( Params::Coerce::_method('foo'),      'foo', '_method("foo") returns correctly' );
is( Params::Coerce::_method('foo::bar'), '',    '_method("foo::bar") returns correctly' );
is( Params::Coerce::_method('1asdf'),    '',    '_method("1asdf") return correctly' );

# Test _class
is( Params::Coerce::_class(),           '',          '_class() returns correctly' );
is( Params::Coerce::_class(undef),      '',          '_class(undef) returns correctly' );
is( Params::Coerce::_class(1),          '',          '_class(1) returns correctly' );
is( Params::Coerce::_class([]),         '',          '_class([]) returns correctly' );
is( Params::Coerce::_class(' '),        '',          '_class(" ") returns correctly' );
is( Params::Coerce::_class('foo'),      'foo',       '_class("foo") returns correctly' );
is( Params::Coerce::_class('foo::bar'), 'foo::bar',  '_class("foo::bar") returns correctly' );
is( Params::Coerce::_class('1asdf'),    '',          '_class("1asdf") return correctly' );
is( Params::Coerce::_class('::'),       'main',      '_class("::") returns correctly' );
is( Params::Coerce::_class('::bar'),    'main::bar', '_class("::bar") returns correctly' );

# Test _loaded
ok(   Params::Coerce::_loaded('Params::Coerce'), '_loaded returns true for Params::Coerce' );
ok( ! Params::Coerce::_loaded('Params::Coerce::Bad'), '_loaded returns false for Params::Coerce::Bad' );

# Test _function_exists
ok(   Params::Coerce::_function_exists('Params::Coerce', '_function_exists'), '_function_exists sees itself' );
ok( ! Params::Coerce::_function_exists('Foo', 'bar'), '_function_exists doesn\' see non-existant function' );
ok( ! Params::Coerce::_function_exists('Params::Coerce', 'VERSION'),
	'_function_exists does not return true for other variable types' );

exit(0);
