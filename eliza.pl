#!/usr/bin/perl
##############################################################################
#
# Eggdrop Eliza personality
# Copyright (C) 2003-2004 by Tim Niemueller <tim@niemueller.de>
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
# 
# Created  : April 2003
#
# $Id: eliza.pl,v 1.1 2004/01/25 23:00:57 tim Exp $
#
##############################################################################

use strict;
use Chatbot::Eliza;

if (scalar(@ARGV) < 2) {
  die "Usage: eliza BotName UserMsg";
}

my $botname = $ARGV[0];
my $msg = $ARGV[1];

my $bot = new Chatbot::Eliza($botname);

# Seed the random number generator.
srand( time ^ ($$ + ($$ << 15)) );      

my $bot_says = $bot->transform( $msg );
print $bot_says;

##END.
