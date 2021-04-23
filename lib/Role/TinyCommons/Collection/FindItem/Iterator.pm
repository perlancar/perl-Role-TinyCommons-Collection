package Role::TinyCommons::Collection::FindItem::Iterator;

# AUTHORITY
# DATE
# DIST
# VERSION

use Role::Tiny;
use Role::Tiny::With;

### implements

with 'Role::TinyCommons::Collection::FindItem';

### requires

requires 'each_item';

### provides

sub find_item {
}

1;
# ABSTRACT: Provides find_item() for resettable iterators

=head1 DESCRIPTION

This role provides find_item() that searches a resettable iterator linearly.


=head1 ROLES MIXED IN

L<Role::TinyCommons::Collection::FindItem>


=head1 REQUIRED METHODS

=head2 each_item

Described in L<Role::TinyCommons::Iterator::Resettable> or
L<Role::TinyCommons::Iterator::Circular>.


=head1 PROVIDED METHODS

=head2 find_item

Usage:

 my $item = ;

=head1 SEE ALSO

L<Role::TinyCommons::Collection::FindItem>

L<Role::TinyCommons::Iterator::Resettable>,
L<Role::TinyCommons::Iterator::Circular>.
