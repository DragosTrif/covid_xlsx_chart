package XlsChart;

use Mojo::Base -base;
use Excel::Writer::XLSX;

has config => sub { {} };
has aoa    => sub { [] };
has xls => sub { Excel::Writer::XLSX->new( 'covid.xlsx' ); };

sub make_array_of_arrays {
  my ( $self, $data ) = @_;


  my $xls_raw_data = [];
  my $graph_data   = {};

  while ( my ( $date, $count ) = each %{$data} ) {
    push @{$xls_raw_data}, [ $date, $count ];
  }

  @{$xls_raw_data} = sort { $a->[0] cmp $b->[0] } @{$xls_raw_data};

  foreach my $record ( @{$xls_raw_data} ) {
    push @{ $graph_data->{categories} }, $record->[0];
    push @{ $graph_data->{values} },     $record->[1];
  }

  $self->aoa( [ $graph_data->{categories}, $graph_data->{values} ] );

  return $self;
}

sub write_chart {
  my ( $self, $sheet_name ) = @_;
  
  my $data = $self->aoa();
  my $config = $self->config();

  my $worksheet = $self->xls()->add_worksheet( $sheet_name );
  my $chart     = $self->xls()->add_chart( type => 'bar', embedded => 1 );

  my $last_index = scalar @{ $data->[0] };

  $chart->add_series(
    categories => '=' . $sheet_name  . '!$E$2:$E$' . $last_index,
    values     => '=' . $sheet_name  . '!$F$2:$F$' . $last_index,
  );

  $chart->set_title ( name => $config->{title} );
  $chart->set_x_axis( name => $config->{x_axis_name} );
  $chart->set_y_axis( name => $config->{y_axis_name} );
  $chart->set_size( width  => $config->{width}, height => $config->{height} );

  $worksheet->write( 'E1', $data );
  $worksheet->insert_chart( 'E1', $chart, 40, 20 );

  return $self;
}
1;