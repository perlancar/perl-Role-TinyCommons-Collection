package Role::TinyCommons::Collection::GetItemByPos;

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

This role is for ordered collections that support locating an item via an
integer position (0 is the first, 1 the second and so on). Arrays are example of
such collections. This operation is a more specific type of getting an item by
key (see L<Role::TinyCommons::Collection::GetItemByKey>).


=head1 REQUIRED METHODS

=head2 get_item_at_pos

Usage:

 my $item = $obj->get_item_at_pos($pos); # dies when not found

Return item at position C<$pos> (0-based integer). Method must die when there is
no item at such position.

=head2 has_item_at_pos

Usage:

 my $has_item = $obj->has_item_at_pos($pos); # => bool

Check whether the collection has item at position C<$pos>.


=head1 SEE ALSO

L<Role::TinyCommons::Collection::GetItemByKey>
