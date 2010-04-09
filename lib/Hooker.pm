package Hooker;
use Moose;
use Plack::Response;
use namespace::clean -except => 'meta';

sub index {
    my $self = shift;
    my $req  = shift;
    my $p    = shift;

    my $message = 'VHS Web Hookers';
    if ($p->{hooker} =~ m/^(\w+)$/) {
        my $name = $1;
        my $project_dir = "/var/www/$name";
        if (-e "$project_dir/.git") {
            $message = qx{ 
                cd $project_dir && 
                git fetch &&
                git reset --hard origin/master 
            };
        }
    }

    my $resp = Plack::Response->new(200);
    $resp->content_type('text/plain');
    $resp->body( $message );
    return $resp->finalize;
}

__PACKAGE__->meta->make_immutable;
1;
