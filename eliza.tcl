##############################################################################
#
# Eggdrop Eliza Extension
# Copyright (C) 2003-2004 by Tim Niemueller <tim@niemueller.de>
# http://www.niemueller.de/software/eggdrop/eliza/
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
# Created  : May 14th 2003
#
# $Id: eliza.tcl,v 1.1 2004/01/25 23:00:57 tim Exp $
#
##############################################################################

###CONFIGSTART###

# The channles Fangorn should listen to
set eliza(channels) "#math"

# This has to be set since $botnick is not available during boot,
# only after rehashing(don't know why)
# Set this to the strings that the bot should answer to, the botnick is
# a good start
set eliza(botnicks) "Fangorn Fangi"

# Where is your Perl binary?
set perlbin "/usr/bin/perl"

# Full path to the eliza Perl script
set perleliza "/server/irc/eggdrop/scripts/eggeliza/eliza.pl"

###CONFIGEND###


# Unbind all first, channels may have changed
foreach b [binds] {

  if { [lindex $b 4] == "eliza_answer" } {
    set type [lindex $b 0]
    set flags [lindex $b 1]
    set name [lindex $b 2]
    unbind $type $flags $name eliza_answer
  }
}


# Bindings
bind pub - !eliza eliza_answer

foreach c $eliza(channels) {
  foreach n $eliza(botnicks) {
    bind pubm - "$c *$n*" eliza_answer
  }
}



### PROCs

proc eliza_answer {nick uhost hand chan text} {
global botnick perlbin perleliza
  set f [open "|$perlbin $perleliza $botnick $text"]
  set output [read $f]
  close $f
  set lines [split $output "\n"]

  foreach l $lines {
    putserv "PRIVMSG $chan :$l"
    putloglev p $chan "<$botnick> $l"
  }

}



putlog "Eliza v0.2 by Tim Niemueller \[http://www.niemueller.de\] loaded"

