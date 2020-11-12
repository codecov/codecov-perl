use strict;
use warnings FATAL => 'all';
use utf8;

use lib '.';
use t::Util;
use Devel::Cover::Report::Codecov::Service::GitHub;

sub github { 'Devel::Cover::Report::Codecov::Service::GitHub' }

subtest 'if GitHub' => sub {
    local $ENV{GITHUB_ACTIONS} = 1;
    ok( github->detect );
};

subtest 'if not GitHub' => sub {
    local $ENV{GITHUB_ACTIONS} = 0;
    ok( not github->detect );
};

done_testing;
