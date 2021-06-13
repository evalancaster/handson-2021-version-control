# Git Tag

## Lightweight Tags

running [git tag](https://git-scm.com/docs/git-tag) with no arguments.

    git tag stable-1 1b2e1d63ff

After that, we can use stable-1 to refer to the commit 1b2e1d63ff.

*tag object* instead.

If one of **-a**, **-s**, or **-u *key-id*** is passed

like this:

    git tag -a stable-1 1b2e1d63ff

It is actually possible to tag any object, but tagging commit objects is the
most common. (In the Linux kernel source, the first tag object
references a tree, rather than a commit)

## Signed Tags

If you have a GPG key setup, you can create signed tags fairly easily.  First,
you will probably want to setup your key id in your _.git/config_ or _~.gitconfig_
file.

    [user]
        signingkey = <gpg-key-id>

You can also set that with

    git config (--global) user.signingkey <gpg-key-id>

Now you can create a signed tag simply by replacing the **-a** with a **-s**.

    git tag -s stable-1 1b2e1d63ff

If you don't have your GPG key in your config file, you can accomplish the same
thing this way:

    git tag -u <gpg-key-id> stable-1 1b2e1d63ff
