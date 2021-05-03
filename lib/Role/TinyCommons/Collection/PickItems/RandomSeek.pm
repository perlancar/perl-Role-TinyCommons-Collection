package Role::TinyCommons::Collection::PickItems::RandomSeek;

# AUTHORITY
# DATE
# DIST
# VERSION

# enabled by Role::Tiny
#use strict;
#use warnings;

use Role::Tiny;

requires 'get_item_count';
requires 'get_item_at_pos';

sub pick_items {
    my ($self, %args) = @_;

    my $n = $args{n} || 1;
    my $allow_resampling = defined $args{allow_resampling} ? $args{allow_resampling} : 0;
    my $item_count = $self->get_item_count;

    $n = $item_count if $n > $item_count;

    my @items;
    my %used_pos;
    while (@items < $n) {
        my $pos = int(rand() * $item_count);
        unless ($allow_resampling) {
            next if $used_pos{$pos}++;
        }
        push @items, $self->get_item_at_pos($pos);
    }
    @items;
}

1;
# ABSTRACT: Provide pick_items() that gets items by random seeking

=for Pod::Coverage ^(.+)$

=head1 DESCRIPTION

This role provides pick_items() that picks random items by random seeking. It is
more suitable for huge collections that support C<get_item_at_pos> (see
L<Role::TinyCommons::Collection::Position>) and an efficient C<get_item_count>.
If your collection does not support those methods, there's an alternative you
can use: L<Role::TinyCommons::FindItems::Iterator>.


=head1 ROLES MIXED IN

L<Role::TinyCommons::Collection::PickItems>


=head1 REQUIRED METHODS

=head2 get_item_at_pos

=head2 get_item_count


=head1 SEE ALSO

L<Role::TinyCommons::Collection::PickItems> and other
C<Role::TinyCommons::Collection::PickItems::*>.
