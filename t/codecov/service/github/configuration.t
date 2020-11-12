use strict;
use warnings FATAL => 'all';
use utf8;

use lib '.';
use t::Util;
use Devel::Cover::Report::Codecov::Service::GitHub;

subtest basic => sub {
    local $ENV{GITHUB_REF}        = 'refs/heads/branch';
    local $ENV{GITHUB_SHA}        = 'commit';
    local $ENV{GITHUB_REPOSITORY} = 'owner/repo';
    local $ENV{GITHUB_RUN_ID}     = 'run_id';

    my $configuration = Devel::Cover::Report::Codecov::Service::GitHub->configuration;
    cmp_deeply
        $configuration,
        {
            service   => 'github-actions',
            commit    => 'commit',
            slug      => 'owner/repo',
            build     => 'run_id',
            build_url => 'https://github.com/owner/repo/actions/runs/run_id',
            branch    => 'branch',
        };
};

subtest pr => sub {
    local $ENV{GITHUB_REF}        = 'refs/pull/num/merge';
    local $ENV{GITHUB_SHA}        = 'commit';
    local $ENV{GITHUB_REPOSITORY} = 'owner/repo';
    local $ENV{GITHUB_RUN_ID}     = 'run_id';
    local $ENV{GITHUB_HEAD_REF}   = 'refs/heads/branch';

    my $configuration = Devel::Cover::Report::Codecov::Service::GitHub->configuration;
    cmp_deeply
        $configuration,
        {
            service   => 'github-actions',
            commit    => 'commit',
            slug      => 'owner/repo',
            build     => 'run_id',
            build_url => 'https://github.com/owner/repo/actions/runs/run_id',
            branch    => 'refs/heads/branch',
            pr        => 'num',
        };
};

done_testing;
