#!/usr/bin/env perl

##
# 
my $USER=`whoami`;
my $WATCH_PATH=$ARGV[0];
my $USE_GROWL=1;
my $GIT = `which git`;
chomp $GIT;
my $GROWL = `which growlnotify`;
chomp $GROWL;

_check_watch_dir($WATCH_PATH);

my $status= `cd $WATCH_PATH; $GIT status`;

if ($status =~ /modified|untracked\ files\ present|deleted/) {
    my $out = `cd $WATCH_PATH; $GIT add .; $GIT commit -a -m "Veloci-Wiki Update"; $GIT push;`;
    
    ### use growl if available
    if (-f $GROWL) {
        print "Veloci-Wiki Update: Your Notes Wiki was updated:\n$out";
        `$GROWL 'Veloci-Wiki Update' -m "Your Notes Wiki was updated:\n$out"`;
    }
} else {
    print "Veloci-Wiki Update: No update needed.\n"
}

###
sub _check_watch_dir {
    my $wd = shift;
    if (! -d "$wd/.git") {
        _log("Watch directory ($wd) is not a Git repository!");
        exit(1);
    }
    1;
}
