use strict;
use warnings FATAL => 'all';
use utf8;

use Test::MockObject;

use t::Util;
use Devel::Cover::Report::Codecov;

sub get_line_coverage_by_location {
    Devel::Cover::Report::Codecov::get_line_coverage_by_location(@_);
}

subtest 'if false' => sub {
    is get_line_coverage_by_location(undef), undef;
};

subtest 'if uncoverable' => sub {
    my $location = Test::MockObject->new;
    $location->mock(uncoverable => sub { 1 });
    $location->mock(covered => sub { 0 });

    is get_line_coverage_by_location([$location]), undef;
};

subtest 'if covered' => sub {
    my $location = Test::MockObject->new;
    $location->mock(uncoverable => sub { 0 });
    $location->mock(covered => sub { 1024 });

    is get_line_coverage_by_location([$location]), 1024;
};

done_testing;
