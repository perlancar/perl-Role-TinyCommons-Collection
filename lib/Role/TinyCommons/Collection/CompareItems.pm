package Role::TinyCommons::Collection::CompareItems;

# AUTHORITY
# DATE
# DIST
# VERSION

use Role::Tiny;

### required methods

requires 'cmp_items';

1;
# ABSTRACT: The cmp_items() interface

=head1 SYNOPSIS


=head1 DESCRIPTION


=head1 REQUIRED METHODS

=head2 cmp_items

Usage:

 my $res = $obj->cmp_item($item1, $item2); # => -1|0|1

Compare two items. Must return either -1, 0, or 1. This is the standard Perl's
C<cmp> and C<< <=> >> semantic.


=head1 SEE ALSO

Perl's C<cmp> and C<< <=> >> operator.

L<Data::Cmp>
