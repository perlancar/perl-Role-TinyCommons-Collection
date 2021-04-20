package Role::TinyCommons::Collection::PickItems;

# AUTHORITY
# DATE
# DIST
# VERSION

use Role::Tiny;

### required methods

requires 'pick_items';

### provided methods

sub pick_item {
    my ($self, %args) = @_;
    my @items = $self->pick_items(n => 1, %args);
    @items ? $items[0] : undef;
}

1;
# ABSTRACT: The pick_items() interface

=head1 SYNOPSIS

In your class:

 package YourClass;
 use Role::Tiny::With;
 with 'Role::TinyCommons::Collection::PickItems';

 sub new { ... }
 sub pick_items { ... }
 ...
 1;

In the code of your class user:

 use YourClass;

 my $obj = YourClass->new(...);

 # pick 5 random items, without duplicates (but duplicate values are still possible)
 my @items = $obj->pick_items(n=>5);

 # pick 5 random items, duplicates allowed
 my @items = $obj->pick_items(n=>5, allow_resampling=>1);

 # pick a single random item, or undef if item is empty
 my $item = $obj->pick_item;


=head1 DESCRIPTION

C<pick_items()> is an interface to get one or more random items from a
collection. Some options are provided. The implementor is given flexibility to
support additional options, but the basic modes of picking must be supported.


=head1 REQUIRED METHODS

=head2 pick_items

Usage:

 my @items = $obj->pick_items(%args);

Pick one or more random items from a collection. By default picks one item
(L</n>=1).

Arguments:

=over

=item * n

Type: posint (positive integer). Pick this many random items from the
collection. By default resampling is not allowed. If there are only less than
I<n> items in the collection, then only that number of items should be returned.

This argument must be supported.

=item * allow_resampling

Type: bool. Defaults to false. If set to false, then resampling is not allowed.
Otherwise, resampling is allowed resulting in possible duplicates in the result.

This argument is optional to implement.

=back


=head1 PROVIDED METHODS

=head2 pick_item

Usage:

 my $item = $obj->pick_item(%args);

Equivalent to:

 my @items = $obj->pick_items(n => 1, %args);
 return @items ? $items[0] : undef;


=head1 SEE ALSO
