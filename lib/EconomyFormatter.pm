#!/usr/bin/perl -wT
###############################################################################

package EconomyFormatter;

use strict;
use warnings;
use vars qw(@ISA @EXPORT_OK $VERSION $XS_VERSION $TESTING_PERL_ONLY);
use base qw(Exporter);
@EXPORT_OK = qw( printResources printBusinesses);

###############################################################################

=head1 NAME

    EconomyFormatter - used to format the economy.

=head1 DESCRIPTION

 This take a city, strips the important info, and generates a Summary of economy details.

=cut

###############################################################################

use Carp;
use CGI;
use Data::Dumper;
use Exporter;
use List::Util 'shuffle', 'min', 'max';
use Lingua::Conjunction;
use Lingua::EN::Inflect qw(A PL_N);
use Lingua::EN::Numbers qw(num2en);
use Number::Format;
use POSIX;
use version;
use Template;

###############################################################################

=head2 printResources()

printResources strips out important info from a City object and returns formatted text.

=cut

###############################################################################
sub printResources {
    my $city = shift;
    my $content;

    my $tt = Template->new;

    my $template = resource_template ();

    $tt->process(\$template, $city, \$content);

    return $content || $tt->error;
}

sub resource_template {
    return <<"END_RESOURCE_TEMPLATE"
[% IF city.resources %]
    <p> [% city.name %] is known for the following resources:</p>
    <ul class='threecolumn'>
    [% FOREACH resource IN city.resources %]
        <li> [% resource.content %] </li>
    [% END %]
    </ul>
[% ELSE %]
    <p>There are no resources worth mentioning.</p>
[% END %]
END_RESOURCE_TEMPLATE
}

1;

__END__


=head1 AUTHOR

Jesse Morgan (morgajel)  C<< <morgajel@gmail.com> >>

=head1 LICENSE AND COPYRIGHT

Copyright (c) 2013, Jesse Morgan (morgajel) C<< <morgajel@gmail.com> >>. All rights reserved.

This program is free software; you can redistribute it and/or
modify it under the terms of the GNU General Public License
as published by the Free Software Foundation version 2
of the License.

You should have received a copy of the GNU General Public License
along with this program; if not, write to the Free Software
Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.

=head1 DISCLAIMER OF WARRANTY

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

=cut
