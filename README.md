# Veloci-Wiki

Veloci-wiki is not a wiki, per se. Rather, it's an easy way to set up your [Notational Velocity](http://notational.net) install to store note data in a [Github](http://github.com) wiki. This makes NV a great note editor AND a great wiki editor!

See the first blog post [here](http://www.monkinetic.com/2011/02/wiring-notational-velocity-to-a-github-wiki.html) for more info.

# Usage

## Github Setup

Fork this project on github to your own account and create a local clone.

    % git clone git@github.com:<you>/veloci-wiki.git

Create your wiki by going to "Wiki" and clicking "Create Wiki"

<img src="https://img.skitch.com/20110209-testx7sund75f4cwnq43y14b43.png" style="border:1px solid #999"/>

After the wiki is created, click the "Git Access" button on the wiki home page and copy the git URL, which will look something like: `git@github.com:<you>/veloci-wiki.wiki.git`
    
<img src="https://img.skitch.com/20110209-kcpp64uhsy6eknqiwwiqdaug1n.png" style="border:1px solid #999"/>
    
Clone the wiki repo somewhere on your local drive and write down or copy the path:

    % git clone git@github.com:<you>/veloci-wiki.wiki.git
    % cd veloci-wiki.wiki; pwd | pbcopy

In the cloned veloci-wiki repo, run:

    % perl setup.pl &lt;path to your wiki checkout>

You should see something like:

    % perl setup.pl /Users/you/tmp/veloci-wiki.wiki
    Setting up veloci-wiki...
    Watching: /Users/you/tmp/veloci-wiki.wiki
    Creating launchd plist for watcher at:
    /Users/you/Library/LaunchAgents/local.you.veloci-wiki-update.plist
    Restarting launchd...

You can ignore any warnings like:

    % launchctl: Error unloading: <some file>

## Notational Velocity Setup

You are using it, or downloaded it, right?

Launch NV if it's not running. Open the Preferences and click on "Notes". Next to "Read notes from folder", pick "Other..." from the drop down and select the directory into which you cloned your wiki.

<img src="https://img.skitch.com/20110209-chd6tba37ubie8645idami31us.png" style="border:1px solid #999"/>

Then, click on "Storage" and change your settings to use "Plain Text Files" (in [nvalt](http://brettterpstra.com/code/notational-velocity-alt/), a fork of Notational Velocity, I use the "Zettelkasten (Markup text Files)" setting, but it works either way):

<img src="https://img.skitch.com/20110209-bgxebb3r9fmaipcwup3pfm62er.png" style="border:1px solid #999"/>


