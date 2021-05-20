package Role::TinyCommons::Collection::PickItems::RandomSeekLines;

# AUTHORITY
# DATE
# DIST
# VERSION

# enabled by Role::Tiny
#use strict;
#use warnings;

use Role::Tiny;

requires 'fh';
# optionally depended methods
# fh_min_offset
# fh_max_offset
# cmp_items

sub pick_items {
    my ($self, %args) = @_;
    my $n = $args{n} || 1;
    my $allow_resampling = defined $args{allow_resampling} ? $args{allow_resampling} : 0;
    my $max_attempts = $args{max_attempts} || 10_000;

    my $fh = $self->fh;
    my $fh_min_offset = $self->can('fh_min_offset') ? $self->fh_min_offset : 0;
    my $fh_max_offset = $self->can('fh_max_offset') ? $self->fh_max_offset : undef;
    unless (defined $fh_max_offset) {
        my @st = stat($fh) or die "Can't stat filehandle: $!";
        $fh_max_offset = $st[7]-1;
    }
    #print "D:fh_min_offset=$fh_min_offset, fh_max_offset=$fh_max_offset\n";

    return () unless $fh_max_offset >= 0 && $fh_max_offset > $fh_min_offset;

    my @items;
    my %used_pos;
    my $attempts = 0;
  PICK:
    while (@items < $n) {
        if ($attempts++ > $max_attempts) {
            warn "max_attempts exceeded, only picked ".scalar(@items)." out of $n";
            last PICK;
        }

        my ($line, $pos);
      GET_RANDOM_LINE: {
            my $pos0 = int(rand($fh_max_offset-$fh_min_offset+1)) + $fh_min_offset;
            seek $fh, $pos0, 0; # XXX this is random *bytes*
            if ($pos0 > $fh_min_offset) {
                # discard partial line
                <$fh>;
            }
            $line = <$fh>;
            $pos = tell $fh;
            die "Can't tell filehandle position: $!" if $pos < 0;
            next PICK if !defined($line) || ($pos >= $fh_max_offset && $line !~ /\R\z/);
            #print "D:line=<$line>\n";
            chomp($line);
        }

        unless ($allow_resampling) {
            next if $used_pos{$pos}++;
        }
        push @items, $line;
    }
    @items;
}

1;
# ABSTRACT: Provide pick_items() that picks items by random seeking lines in a (file)handle

=for Pod::Coverage ^(.+)$

=head1 DESCRIPTION

This role provides pick_items() that picks random items by seeking lines in a
seekable filehandle. Your class must support these methods to expose the
seekable handle: C<fh> (and optionally C<fh_min_offset> and C<fh_max_offset>)
(if your collection does not meet this requirement, there are other choices in
C<Role::TinyCommons::Collection::PickItems::*>).

The algorithm is as follow:

=over

=item 1.

If C<fh_min_offset> and C<fh_max_offset> is not available, then do a C<stat()>
on the handle to find the size (C<$size>).

=item 2.

Seek to a random position in the handle (if C<fh_min_offset> and
C<fh_max_offset> is available, then seek between these limits; otherwise seek
between 0 and C<$size>.

=item 3.

If we seek to the minimum position (0 or C<fh_min_offset>), we find the next
newiine and get the line as the random item to pick. Otherwise, since we might
seek to the middle of a line, we find the next newline and discard the partial
line first, then get the next line as the random item to pick.

=item 4.

Remove duplicates as needed (unless C<pick_items()>'s C<allow_resampling> option
is set to true). Repeat step 2 and 3 until we get the required number of random
items to pick.

=back

Caveats:

=over

=item *

Each of your item must be a line in the handle (excluding the newline) because
this method bypasses the C<get_next_item()> abstraction.

=item *

Not all lines are picked uniformly. Due to the nature of the algorithm, the
algorithm favors longer lines; longer lines have a greater probability of being
picked.

=back


=head1 ROLES MIXED IN

L<Role::TinyCommons::Collection::PickItems>


=head1 REQUIRED METHODS

=head2 get_item_at_pos

=head2 get_item_count


=head1 SEE ALSO

L<File::RandomLine>

L<Role::TinyCommons::Collection::PickItems> and other
C<Role::TinyCommons::Collection::PickItems::*>.
