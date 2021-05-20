package Role::TinyCommons::Collection::PickItems::Iterator;

# AUTHORITY
# DATE
# DIST
# VERSION

# enabled by Role::Tiny
#use strict;
#use warnings;

use Role::Tiny;
use Role::Tiny::With;

requires 'get_next_item';
requires 'has_next_item';
requires 'reset_iterator';

with 'Role::TinyCommons::Collection::PickItems';

sub pick_items {
    my ($self, %args) = @_;

    my $n = $args{n} || 1;

    my @items;
    my $i = -1;
    $self->reset_iterator;
    while ($self->has_next_item) {
        $i++;
        my $item = $self->get_next_item;
        if (@items < $n) {
            # we haven't reached $num_items, insert item to array in a random
            # position
            splice @items, rand(@items+1), 0, $item;
        } else {
            # we have reached $num_items, just replace an item randomly, using
            # algorithm from Learning Perl, slightly modified
            rand($i+1) < @items and splice @items, rand(@items), 1, $item;
        }
    }
    @items;
}

1;
# ABSTRACT: Provide pick_items() that picks by iterating all items once

=for Pod::Coverage ^(.+)$

=head1 DESCRIPTION

This role provides C<pick_items()> that picks random items by doing a one-time
full scan (or iteration) of a resettable iterator. The algorithm is a modified
form of one that was presented in Learning Perl book.

Note that for a huge collection, this might not be a good idea. If your
collection supports a fast C<get_item_at_pos> and an efficient
C<get_item_count>, you can use L<Role::TinyCommons::FindItems::RandomPos>. If
your collection's items are lines from a filehandle, you can use
L<Role::TinyCommons::FindItems::RandomSeekLines>.


=head1 ROLES MIXED IN

L<Role::TinyCommons::Collection::PickItems>


=head1 REQUIRED METHODS

=head2 reset_iterator

=head2 get_next_item

=head2 has_next_item


=head1 SEE ALSO

L<Role::TinyCommons::Collection::PickItems> and other
C<Role::TinyCommons::Collection::PickItems::*>.
