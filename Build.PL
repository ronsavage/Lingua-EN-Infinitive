use warnings;
use strict;

use Module::Build;

my $class = Module::Build->subclass(code => <<'EOF');

sub find_test_files
{
	my $self = shift;
	my $files = $self->SUPER::find_test_files(@_);
	return [ grep {!/test\.pl$/} @$files ];
}

sub ACTION_test
{
	my $self = shift;
	$self->SUPER::ACTION_test(@_);
	$self->run_perl_script('test.pl', ['-Mblib='.$self->blib]);
}
EOF

$class -> new
(
	module_name    => 'Lingua::EN::Infinitive',
	license        => 'artistic_2',
	dist_abstract  => 'Determine the infinitive form of a conjugated word',
	dist_author    => 'Ron Savage <ron@savage.net.au>',
	build_requires =>
	{
		'Test::More' => 1.001014,
		'Test::Pod' => 1.48,
	},
	configure_requires =>
	{
		'Module::Build' => 0.4211,
	},
	requires		=>
	{
	},
) -> create_build_script();
