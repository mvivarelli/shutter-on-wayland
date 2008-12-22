###################################################
#
#  Copyright (C) Mario Kemper 2008 <mario.kemper@googlemail.com>
#
#  This file is part of GScrot.
#
#  GScrot is free software; you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation; either version 3 of the License, or
#  (at your option) any later version.
#
#  GScrot is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#  GNU General Public License for more details.
#
#  You should have received a copy of the GNU General Public License
#  along with GScrot; if not, write to the Free Software
#  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
#
###################################################

package GScrot::App::HelperFunctions;

#modules
#--------------------------------------
use utf8;
use strict;
use Gtk2;

#Gettext and filename parsing
use POSIX qw/setlocale strftime/;
use Locale::gettext;

#define constants
#--------------------------------------
use constant TRUE  => 1;
use constant FALSE => 0;

#--------------------------------------

##################public subs##################
sub new {
	my $class = shift;

	#constructor
	my $self = { _common => shift };

	bless $self, $class;
	return $self;
}

sub gnome_open {
	my ( $self, $dialog, $link, $user_data ) = @_;
	system("gnome-open $link");
	return TRUE;
}

sub gnome_open_mail {
	my ( $self, $dialog, $mail, $user_data ) = @_;
	system("gnome-open mailto:$mail");
	return TRUE;
}

sub file_exists {
	my ( $self, $filename ) = @_;
	return FALSE unless $filename;
	$filename = $self->switch_home_in_file($filename);
	return TRUE if ( -f $filename && -r $filename );
	return FALSE;
}

sub switch_home_in_file {
	my ( $self, $filename ) = @_;
	$filename =~ s/^~/$ENV{ HOME }/;    #switch ~ in path to /home/username
	return $filename;
}

sub usage {
	my $self = shift;

	print "gscrot [options]\n";
	print "Available options:\n\n"
		. "Capture:\n"
		. "--full (starts gscrot and takes a full screen screenshot directly)\n"
		. "--selection (starts gscrot in selection mode)\n"
		. "--window (starts gscrot in window selection mode)\n"
		. "--section (starts gscrot in section selection mode)\n\n"
		.

		"Application:\n"
		. "--min_at_startup (starts gscrot minimized to tray)\n"
		. "--clear_cache (clears cache, e.g. installed plugins, at startup)\n"
		. "--debug (prints a lot of debugging information to STDOUT)\n"
		. "--disable_systray (disable systray icon)\n"
		. "--help (displays this help)\n";

	return TRUE;
}

1;