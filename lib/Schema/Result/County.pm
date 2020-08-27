use utf8;
package Schema::Result::County;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

Schema::Result::County

=cut

use strict;
use warnings;

use base 'DBIx::Class::Core';

=head1 COMPONENTS LOADED

=over 4

=item * L<DBIx::Class::InflateColumn::DateTime>

=back

=cut

__PACKAGE__->load_components("InflateColumn::DateTime");

=head1 TABLE: C<counties>

=cut

__PACKAGE__->table("counties");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

=head2 name

  data_type: 'varchar'
  is_nullable: 0
  size: 20

=head2 abbreviation

  data_type: 'varchar'
  is_nullable: 0
  size: 10

=head2 status

  data_type: 'enum'
  default_value: 0
  extra: {list => [0,1]}
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "id",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "name",
  { data_type => "varchar", is_nullable => 0, size => 20 },
  "abbreviation",
  { data_type => "varchar", is_nullable => 0, size => 10 },
  "status",
  {
    data_type => "enum",
    default_value => 0,
    extra => { list => [0, 1] },
    is_nullable => 1,
  },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");

=head1 RELATIONS

=head2 cases

Type: has_many

Related object: L<Schema::Result::Case>

=cut

__PACKAGE__->has_many(
  "cases",
  "Schema::Result::Case",
  { "foreign.county_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07049 @ 2020-08-27 16:25:45
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:RyKnKL4mZUrATTd41Eat2g


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
