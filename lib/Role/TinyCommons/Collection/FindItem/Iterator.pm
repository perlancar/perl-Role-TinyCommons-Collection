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

### optionally depends
# 'cmp_items'; # Role::TinyCommons::Collection::CompareItems

### provides

sub find_item {
    my ($self, %args) = @_;

    my $search_item = $args{item};
    my $return_pos  = $args{return_pos};
    my $all         = $args{all};

    my @results;
    if ($self->can('cmp_items')) {
        $self->each_item(
            sub {
                my ($iter_item, $obj, $pos) = @_;
                if ($obj->cmp_items($iter_item, $search_item) == 0) {
                    push @results, $return_pos ? $pos : $iter_item;
                    return 0 unless $all;
                }
                1;
            });
    } else {
        $self->each_item(
            sub {
                my ($iter_item, $obj, $pos) = @_;
                if (($iter_item cmp $search_item) == 0) {
                    push @results, $return_pos ? $pos : $iter_item;
                    return 0 unless $all;
                }
                1;
            });
    }
    @results;
}

1;
# ABSTRACT: Provides find_item() for iterators

=head1 DESCRIPTION

This role provides find_item() which searches linearly using each_item() and
cmp_items(). each_item() is usually provided by an iterator.


=head1 ROLES MIXED IN

L<Role::TinyCommons::Collection::FindItem>


=head1 REQUIRED METHODS

=head2 each_item

Provided by roles like in L<Role::TinyCommons::Iterator::Resettable> or
L<Role::TinyCommons::Iterator::Circular>.

=head1 OPTIONALLY DEPENDED METHODS

=head2 cmp_items

Usage:

 $res = $obj->cmp_items($item1, $item2); # returns either -1, 0, 1

For flexibility in searching. The method should accept two items and return
either -1, 0, 1 like Perl's C<cmp> or C<< <=> >> operator. See also
L<Role::TinyCommons::Collection::CompareItems> for the more formal encapsulated
form of this interface.


=head1 PROVIDED METHODS

=head2 find_item

Usage:

 my @results = $obj->find_item(%args);

For more details, see L<Role::TinyCommons::Collection::FindItem/find_item>. This
module implements arguments C<item>, C<all>, and C<return_pos>.


=head1 SEE ALSO

L<Role::TinyCommons::Collection::FindItem>

L<Role::TinyCommons::Iterator::Resettable>,
L<Role::TinyCommons::Iterator::Circular>.
