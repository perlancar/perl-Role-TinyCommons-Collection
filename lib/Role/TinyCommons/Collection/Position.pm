package Role::TinyCommons::Collection::Position;

# AUTHORITY
# DATE
# DIST
# VERSION

use Role::Tiny;

### required methods

requires 'get_item_at_pos';
requires 'has_item_at_pos';

1;
# ABSTRACT: Locating an item by an integer position

=head1 SYNOPSIS


=head1 DESCRIPTION

This role is for collections that support locating an item via an integer
position (0 is the first, 1 the second and so on). Arrays are one such
collection. This operation is a more specific type of subscripting (see
L<Role::TinyCommons::Collection::Subscript>).


=head1 REQUIRED METHODS

=head2 get_item_at_pos

Usage:

 my $item = $obj->get_item_at_pos($pos); # dies when not found

Return item at position C<$pos> (0-based integer). Method must die when there is
no item at such position.

=head2 has_item_at_pos

Usage:

 my $has_item = $obj->has_item_at($pos); # => bool

Check whether the collection has item at position C<$pos>.


=head1 SEE ALSO

L<Role::TinyCommons::Collection::Subscript>
