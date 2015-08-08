package Devel::Cover::Report::Codecov::Service::Snap;
use strict;
use warnings;
use utf8;

sub detect {
    return $ENV{SNAP_CI};
}

sub configuration {
    return {
        service      => 'snap',
        build        => $ENV{SNAP_PIPELINE_COUNTER},
        commit       => $ENV{SNAP_COMMIT} // $ENV{SNAP_UPSTREAM_COMMIT},
        branch       => $ENV{SNAP_BRANCH} // $ENV{SNAP_UPSTREAM_BRANCH},
        pull_request => $ENV{SNAP_PULL_REQUEST_NUMBER},
    };
}

1;
__END__
