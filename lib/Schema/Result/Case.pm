use utf8;
package Schema::Result::Case;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

Schema::Result::Case

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

=head1 TABLE: C<cases>

=cut

__PACKAGE__->table("cases");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

=head2 county_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 cases

  data_type: 'integer'
  is_nullable: 0

=head2 record_date

  data_type: 'date'
  datetime_undef_if_invalid: 1
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "id",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "county_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "cases",
  { data_type => "integer", is_nullable => 0 },
  "record_date",
  { data_type => "date", datetime_undef_if_invalid => 1, is_nullable => 0 },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");

=head1 UNIQUE CONSTRAINTS

=head2 C<case_per_day>

=over 4

=item * L</county_id>

=item * L</record_date>

=back

=cut

__PACKAGE__->add_unique_constraint("case_per_day", ["county_id", "record_date"]);

=head1 RELATIONS

=head2 county

Type: belongs_to

Related object: L<Schema::Result::County>

=cut

__PACKAGE__->belongs_to(
  "county",
  "Schema::Result::County",
  { id => "county_id" },
  { is_deferrable => 1, on_delete => "CASCADE", on_update => "CASCADE" },
);


# Created by DBIx::Class::Schema::Loader v0.07049 @ 2020-08-27 16:25:45
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:ILS56rto7PCiHXE+pgyDTg


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
