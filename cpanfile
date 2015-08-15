requires 'perl', '5.008008';

requires 'URI', '1.60';
requires 'Furl', '3.07';
requires 'IO::Socket::SSL', '2.016';
requires 'JSON::XS', '3.01';
requires 'Module::Find', '0.13';

on 'test' => sub {
    requires 'Test::More', '1.001014';
    requires 'Test::Deep', '0.117';
    requires 'Test::Exception', '0.40';
    requires 'Test::Mock::Guard', '0.10';
    requires 'Test::MockObject', '1.20150527';

    requires 'Test::Perl::Critic', '1.03';
    requires 'Perl::Critic', '1.125';

    requires 'Devel::Cover', '1.20';
    requires 'Capture::Tiny', '0.30';
    requires 'Cwd::Guard', '0.04';
};

on 'develop' => sub {
    requires 'Data::Dumper', '2.154';
    requires 'Data::Section::Simple', '0.07';
    requires 'Text::MicroTemplate', '0.24';
};
