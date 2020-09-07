use strict;
use warnings;

use File::Slurper qw( read_text );
use Mojo::UserAgent;
use Mojo::URL;

use FindBin;
use lib "$FindBin::Bin/../lib";
use Schema;

use lib "$FindBin::Bin/../";
my $config = require 'myapp.conf';

my $schema = Schema->connect(
    $config->{db}->{dns},
    $config->{db}->{user},
    $config->{db}->{password},
    { RaiseError => 1, PrintError => 0, AutoCommit => 1, mysql_enable_utf8 => 1 }
  );


my $active_counties_rs =
      $schema->resultset('County')->search( { status => 1 } );

while ( my $result = $active_counties_rs->next() ) {

  my $url = Mojo::URL->new;
  $url->scheme('http');
  $url->path("/covid/chart/" . $result->get_column('abbreviation') );
  $url->host('127.0.0.1:3000');

  print $url->to_string(), "\n";
  my $ua = Mojo::UserAgent->new();
  
  my $tx = $ua->post( $url->to_string );

  unless ( $tx->result->is_success ) {
    die 'Could not make request';
  }
}
