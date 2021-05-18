package Role::TinyCommons::Collection::GetItemByKey;

# AUTHORITY
# DATE
# DIST
# VERSION

use Role::Tiny;

### required methods

requires 'get_item_at_key';
requires 'has_item_at_key';
requires 'get_all_keys';

### provides

# alias for has_item_at_key
sub has_key { my $self = shift; $self->has_item_at_key(@_) }

1;
# ABSTRACT: Locating an item by a key

=head1 SYNOPSIS


=head1 DESCRIPTION

This role is for ordered/mapping collections that support subscripting
operation: locating an item via a single key (an integer like in an array, or a
string like in a hash).


=head1 REQUIRED METHODS

=head2 get_item_at_key

Usage:

 my $item = $obj->get_item_at_key($key); # dies when not found

Return item at key C<$key>. Method must die when there is no item at such key.

=head2 has_item_at_key

Usage:

 my $has_item = $obj->has_item_at_key($key); # => bool

Check whether the collection has item at key C<$key>. In Perl, this is
equivalent to doing C<exists()> on a hash.

=head2 get_all_keys

Usage:

 my @keys = $obj->get_all_keys;

Return all known keys. Note that a specific order is not required.


=head1 PROVIDED METHODS

=head1 has_key

Alias for L</has_item_at_key>.


=head1 SEE ALSO

L<Role::TinyCommons::Collection::GetItemByPos>
