#!/usr/bin/env perl

##
# 
my $USER=`whoami`;
my $WATCH_PATH=$ARGV[0];

my $GROWL = `PATH="\$PATH:/usr/local/bin";which growlnotify`;
chomp $GROWL;

my $GIT = _find_bin('git/bin/git');
unless (-f $GIT) {
    die ("No Git found!");
}

_check_watch_dir($WATCH_PATH);

my $status= `cd $WATCH_PATH; $GIT status`;

if ($status =~ /modified|untracked\ files\ present|deleted/) {
    my $out = `cd $WATCH_PATH; $GIT add .; $GIT commit -a -m "Veloci-Wiki Update"; $GIT push;`;
    _log("Your Notes Wiki was updated:\n$out");
    
    ### use growl if available
    if (-f $GROWL) {
        `$GROWL 'Veloci-Wiki Update' -m "Your Notes Wiki was updated:\n$out"`;
    }
} else {
    _log("No update needed.");
}

#####

sub _log {
    my $msg = shift;
    print "vw-update: $msg\n";
}

sub _check_watch_dir {
    my $wd = shift;
    if (! -d "$wd/.git") {
        _log("Watch directory ($wd) is not a Git repository!");
        exit(1);
    }
    1;
}

sub _find_bin {
    my $target = shift;
    my $paths = `locate $target`;
    my @paths = split(qr{\n},$paths);
    my $res=$paths[0];
    return $res;
}