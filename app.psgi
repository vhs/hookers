#!perl
use Plack::Builder;
use Plack::App::HTTP::Router;
use HTTP::Router::Declare;
use lib '/var/lib/hookers/lib';

my $router = router {
    match '/hookers/{hooker}' => to { controller => 'Hooker', action => 'index' };
};
my $app = Plack::App::HTTP::Router->new({ router => $router} )->to_app;

builder {
#    enable "Plack::Middleware::StackTrace";
    enable "Debug";
    $app;
};

