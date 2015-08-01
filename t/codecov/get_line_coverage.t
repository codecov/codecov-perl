use strict;
use warnings FATAL => 'all';
use utf8;

use Test::MockObject;
use Test::Mock::Guard;

use t::Util;
use Devel::Cover::Report::Codecov;

sub get_line_coverage {
    Devel::Cover::Report::Codecov::get_line_coverage(@_);
}

subtest basic => sub {
    my $statement = Test::MockObject->new;
    $statement->mock(location => sub {
        my ($self, $n) = @_;

        is $self, $statement;
        is $n, 256;

        return 'location';
    });

    my $guard = mock_guard(
        'Devel::Cover::Report::Codecov',
        {
            get_line_coverage_by_location => sub {
                my $location = shift;
                is $location, 'location';
            }
        });

    get_line_coverage($statement, 256);

    ok $statement->called('location');
    is $guard->call_count('Devel::Cover::Report::Codecov', 'get_line_coverage_by_location'), 1;
};

done_testing;
