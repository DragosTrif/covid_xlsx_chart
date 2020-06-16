package XlsChart;

use Mojo::Base -base;
use Excel::Writer::XLSX;

has config => sub { {} };
has aoa    => sub { [] };


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
  my ( $self ) = @_;
  
  my $data = $self->aoa();
  my $config = $self->config();

  my $workbook  = Excel::Writer::XLSX->new( $config->{'xls_name'} );
  my $worksheet = $workbook->add_worksheet( $config->{'sheet'} );
  my $chart     = $workbook->add_chart( type => 'bar', embedded => 1 );

  my $last_index = scalar @{ $data->[0] };

  $chart->add_series(
    categories => '=covid!$E$2:$E$' . $last_index,
    values     => '=covid!$F$2:$F$' . $last_index,
  );

  $chart->set_title ( name => $config->{name} );
  $chart->set_x_axis( name => $config->{x_axis_name} );
  $chart->set_y_axis( name => $config->{y_axis_name} );
  $chart->set_size( width  => $config->{width}, height => $config->{height} );

  $worksheet->write( 'E1', $data );
  $worksheet->insert_chart( 'E1', $chart, 40, 20 );

  return $self;
}
1;