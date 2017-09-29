use strict;
use warnings FATAL => 'all';
use utf8;

use Test::MockObject;
use Test::Mock::Guard;

use lib '.';
use t::Util;
use Devel::Cover::Report::Codecov;

subtest 'without retry' => sub {
    my $url = Test::MockObject->new;
    my $res = Test::MockObject->new;
    my $ok  = { ok => 1 };

    my $guard = mock_guard('Devel::Cover::Report::Codecov', {
        send_report => sub {
            is $_[0], $url;
            is $_[1], $res;
            return $ok;
        },
    });

    my $result = Devel::Cover::Report::Codecov::send_report($url, $res);
    is $result, $ok;

    is $guard->call_count('Devel::Cover::Report::Codecov', 'send_report'), 1;
};

done_testing;
