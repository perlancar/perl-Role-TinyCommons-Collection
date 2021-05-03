package Role::TinyCommons::Collection::Subscript;

# AUTHORITY
# DATE
# DIST
# VERSION

use Role::Tiny;

### required methods

requires 'item_at';

1;
# ABSTRACT: Subscripting operation

=head1 SYNOPSIS


=head1 DESCRIPTION

This role is for collections that support subscripting operation: locating an
item via a single index (an integer like in an array collection, or a string
like in a hash).


=head1 REQUIRED METHODS

=head2 get_item_at

Usage:

 my $item = $obj->get_item_at($subscript); # dies when not found

Return item at subscript C<$subscript>. Method must die when there is no item at
such subscript.

=head2 has_item_at

Usage:

 my $has_item = $obj->has_item_at($subscript); # => bool

Check whether the collection has item at subscript C<$subscript>.


=head1 SEE ALSO
