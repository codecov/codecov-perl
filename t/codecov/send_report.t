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
        send_report_once => sub {
            is $_[0], $url;
            is $_[1], $res;
            return $ok;
        },
    });

    my $result = Devel::Cover::Report::Codecov::send_report($url, $res);
    is $result, $ok;
    is $guard->call_count('Devel::Cover::Report::Codecov', 'send_report_once'), 1;
};

subtest 'with retry' => sub {
    my $url = Test::MockObject->new;
    my $res = Test::MockObject->new;
    my $ok  = { ok => 1 };

    my $count = 0;
    my $guard = mock_guard('Devel::Cover::Report::Codecov', {
        send_report_once => sub {
            is $_[0], $url;
            is $_[1], $res;

            $count++;
            return $count < 5 ? { ok => 0 } : $ok;
        },
    });

    my $result = Devel::Cover::Report::Codecov::send_report($url, $res);
    is $result, $ok;
    is $guard->call_count('Devel::Cover::Report::Codecov', 'send_report_once'), 5;
};

done_testing;
