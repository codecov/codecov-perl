package Devel::Cover::Report::Codecov::Service::Gitlab;
use strict;
use warnings;
use utf8;

sub detect {
  return $ENV{GITLAB_CI};
}

sub configuration {
  return {
    service   => 'gitlab',
    commit    => $ENV{CI_BUILD_REF},
    build     => $ENV{CI_BUILD_ID},
    build_url => "$ENV{CI_PROJECT_URL}/builds/$ENV{CI_BUILD_ID}",
    job       => $ENV{CI_PIPELINE_ID},
    branch    => $ENV{CI_BUILD_REF_NAME},
    repo      => "$ENV{CI_PROJECT_URL}/tree/$ENV{CI_BUILD_REF_NAME}",
    slug      => $ENV{CI_PROJECT_PATH},
  };
}

1;
__END__
