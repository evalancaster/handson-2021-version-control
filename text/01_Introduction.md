# Welcome to Git

Welcome to Git - the fast, distributed version control system.

This book is meant to be a starting point for people new to Git to learn it 
as quickly and easily as possible.

This book will start out by introducing you to the way Git stores data, to 
give you the context for why it is different than other VCS tools.
This is meant to take you about 20 minutes.

Next we will cover **Basic Git Usage** - the commands you will be using 90% of 
the time.  These should give you a good basis to use Git comfortably for most
of what you're going to use it for.  This section should take you about 30 
minutes to read through.

Next we will go over **Intermediate Git Usage** - things that are slightly more
complex, but may replace some of the basic commands you learned in the first 
section.  This will mostly be tricks and commands that will feel more 
comfortable after you know the basic commands.

## Initial Setup

After installing Git on your system, the first thing you should do is setting
up your name and email address used to sign your commits.

    $ git config --global user.name "Brian Hack"
    $ git config --global user.email "brianhack@hippo.campus"

That will set up a file in your home directory which may be used by any of
your projects. By default that file is *~/.gitconfig* and the contents will
look like this:

    [user]
            name = Brian Hack
            email = brianhack@hippo.campus
            
If you want to override those values for a specific project (to use a work
email address, for example), you can run the *git config* command without the
*--global* option while in that project. This will add a [user] section like
the one shown above to the *.git/config* file in your project's root
directory.

## 'git help' Pages

Git includes a detailed manual on every command. If you are unsure about any
command, try `git help` followed by the command on the terminal. Within the
manual pages, you can search for keywords by pressing `/`.

## References

* [Git User Manual](http://www.kernel.org/pub/software/scm/git/docs/user-manual.html)
* [The Git Tutorial](http://www.kernel.org/pub/software/scm/git/docs/gittutorial.html)
* [The Git Tutorial pt 2](http://www.kernel.org/pub/software/scm/git/docs/gittutorial-2.html)
