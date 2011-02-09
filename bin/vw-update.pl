#!/usr/bin/env perl

##
# 
my $USER=`whoami`;
my $WATCH_PATH='';
my $USE_GROWL=1;

my $status= `cd $WATCH_PATH; /usr/local/git/bin/git status`;

if ($status =~ /modified|untracked\ files\ present|deleted/) {
    my $out = `cd $WATCH_PATH; /usr/local/git/bin/git add .; /usr/local/git/bin/git commit -a -m "NV Wiki Update"; /usr/local/git/bin/git push;`;
    `/usr/local/bin/growlnotify 'NV Wiki Update' -m "Your Notes Wiki was updated:\n$out"`;
} else {
    print "NV Wiki Update: No update needed.\n"
}
