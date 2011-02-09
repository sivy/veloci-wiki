#!/usr/bin/env perl

use strict;
use warnings;

my $WATCH_PATH = $ARGV[0];

unless($WATCH_PATH) {
    die "Usage: $0 <path to wiki checkout>"
}

print "Setting up veloci-wiki...\n";

my $USER = `whoami`;
chop $USER;

my $CWD = `pwd`;
chop $CWD;

_check_watch_dir($WATCH_PATH);

_log("Watching: $WATCH_PATH");

my $PLIST_ID = "local.$USER.veloci-wiki-update";

my $plist = <<"PLIST";
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
	<key>Disabled</key>
	<false/>
	<key>Label</key>
	<string>$PLIST_ID</string>
	<key>ProgramArguments</key>
	<array>
		<string>perl</string>
		<string>$CWD/bin/vw-update.pl</string>
		<string>$WATCH_PATH</string>
	</array>
	<key>WatchPaths</key>
	<array>
	    <string>$WATCH_PATH</string>
	</array>
</dict>
</plist>
PLIST

if (! -d "/Users/$USER/Library/LaunchAgents") {
    _log("Creating LaunchAgents directory...");
    `mkdir /Users/$USER/Library/LaunchAgents`;
}

_log("Creating launchd plist for watcher at:");
_log("/Users/$USER/Library/LaunchAgents/$PLIST_ID.plist");

open(my $plist_file, '>',
     "/Users/$USER/Library/LaunchAgents/$PLIST_ID.plist") or die $!;
print $plist_file $plist;
close($plist_file);

_log("Restarting launchd...");
`launchctl unload ~/Library/LaunchAgents/`;
`launchctl load ~/Library/LaunchAgents/`;

#####

sub _log {
    my $msg = shift;
    print "$msg\n";
}

sub _check_watch_dir {
    my $wd = shift;
    if (! -d "$wd/.git") {
        _log("Watch directory ($wd) is not a Git repository!");
        exit(1);
    }
    1;
}