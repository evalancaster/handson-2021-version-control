# Finding with Git Grep

Finding files with words or phrases in Git is really easy with the
[git grep](https://git-scm.com/docs/git-grep) command. It is possible to do this
with the normal unix 'grep' command, but with 'git grep' you can also search
through previous versions of the project without having to check them out.

For example, if I wanted to see every place that with 'figure' links in this
git repository, I could run this:

    $ git grep 'figure/'
    text/02_Git_Object_Model.md:![Blob named 5b1d3.. with some code](../figure/object-blob.png)
    text/02_Git_Object_Model.md:![Tree named c36d4.. with some file blobs and dir trees](../figure/
      object-tree.png)
    text/02_Git_Object_Model.md:![Commit named ae668.. with tree, parent, author, committer, messag
      e](../figure/object-commit.png)
    text/02_Git_Object_Model.md:![A commit with 3 nested trees and blobs](../figure/objects-example
      .png)
    text/02_Git_Object_Model.md:![Tag named 49e11.. with object, type, tagger](../figure/object-tag
      .png)
    text/13_Rebasing.md:![origin and mywork point to commit C2](../figure/rebase0.png)
    text/13_Rebasing.md:![origin (C4) and mywork (C6) diverge at C2](../figure/rebase1.png)
    text/13_Rebasing.md:![git merge creates C7 by combining C4 and C6](../figure/rebase2.png)
    text/13_Rebasing.md:![git rebase applies C5' and C6' to origin (C4)](../figure/rebase3.png)
    text/13_Rebasing.md:![mywork moves to C6' then C5 and C6 are removed](../figure/rebase4.png)
    text/13_Rebasing.md:![git rebase results in linear history while git merge diverge and converge
      ](../figure/rebase5.png)

If I wanted to see the line number of each match as well, I can add the '-n'
option:

    $ git grep -n 'figure/object'
    text/02_Git_Object_Model.md:61:![Blob named 5b1d3.. with some code](../figure/object-blob.png)
    text/02_Git_Object_Model.md:88:![Tree named c36d4.. with some file blobs and dir trees](../figu
      re/object-tree.png)
    text/02_Git_Object_Model.md:129:![Commit named ae668.. with tree, parent, author, committer, me
      ssage](../figure/object-commit.png)
    text/02_Git_Object_Model.md:195:![A commit with 3 nested trees and blobs](../figure/objects-exa
      mple.png)
    text/02_Git_Object_Model.md:204:![Tag named 49e11.. with object, type, tagger](../figure/object
      -tag.png)

If we're only interested in the filename, we can pass the '--name-only' option:

    $ git grep --name-only 'figure/'
    text/02_Git_Object_Model.md
    text/13_Rebasing.md

We could also see how many line matches we have in each file with the '-c'
option:

    $ git grep -c 'figure/'
    text/02_Git_Object_Model.md:5
    text/13_Rebasing.md:6

Now, if I wanted to see where figures were used in a specific version of the
repository, I could add a commit or tag reference to the end, like this:

    $ git grep 'figure/' 929f810
    929f810:script/html.rb:  html.gsub! /\[fig:(.*?)\]/, '<div class="center"><img src="images/figu
      re/\1.png"></div>'
    929f810:text/02_Git_Object_Db_Basics/1_Trees_and_Blobs.markdown:![blob object](../../assets/ima
      ges/figure/object-blob.png)

We can see that there are only a few lines with figure links in commit 929f810,
which was just a markdown image test.

## Advanced Search

We can also combine search terms in grep. Say we wanted to search for where
SORT_DIRENT is defined in a repository:

    $ git grep -e '#define' --and -e SORT_DIRENT
    builtin-fsck.c:#define SORT_DIRENT 0
    builtin-fsck.c:#define SORT_DIRENT 1

We can also search for every file that has *both* search terms, but display
each line that has *either* of the terms in those files:

    $ git grep --all-match -e '#define' -e SORT_DIRENT
    builtin-fsck.c:#define REACHABLE 0x0001
    builtin-fsck.c:#define SEEN      0x0002
    builtin-fsck.c:#define ERROR_OBJECT 01
    builtin-fsck.c:#define ERROR_REACHABLE 02
    builtin-fsck.c:#define SORT_DIRENT 0
    builtin-fsck.c:#define DIRENT_SORT_HINT(de) 0
    builtin-fsck.c:#define SORT_DIRENT 1
    builtin-fsck.c:#define DIRENT_SORT_HINT(de) ((de)->d_ino)
    builtin-fsck.c:#define MAX_SHA1_ENTRIES (1024)
    builtin-fsck.c: if (SORT_DIRENT)

We can also search for lines that have one term and either of two other terms,
for example, if we wanted to see where we defined constants that had either
PATH or MAX in the name:

    $ git grep -e '#define' --and \( -e PATH -e MAX \)
    abspath.c:#define MAXDEPTH 5
    builtin-blame.c:#define MORE_THAN_ONE_PATH      (1u<<13)
    builtin-blame.c:#define MAXSG 16
    builtin-describe.c:#define MAX_TAGS     (FLAG_BITS - 1)
    builtin-fetch-pack.c:#define MAX_IN_VAIN 256
    builtin-fsck.c:#define MAX_SHA1_ENTRIES (1024)
    ...
