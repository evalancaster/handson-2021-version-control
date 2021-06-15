# Contributing to a Repository

While Git can be used for personal version control, it truly shines when used in conjunction with GitHub as a collaborative tool. The general functionality and structure of Git reflects that it was developed so that repositories could be edited by many people simultaneously.

Follow a few simple steps to establish a collaborative workflow.

![Collaborative Workflow](../figure/collab_workflow.png)

1. **Fork project you're interested in contributing to.** This copies the project repository and history to your own personal GitHub account. Find the project repository on GitHub and click the "Fork" button. This will take you to a copy of the repository in your account. 

2. **Clone fork to your local computer.** This copies the fork from GitHub to a subdirectory on your local machine. This is where you will edit the files and add your contribution from your local machine. 

```git clone https://github.com/evalancaster/handson-2021-version-control```

Here you can check that your repository was configured correctly and check that Git is accurately tracking where your repository originated from. Navigate to your local repository. The repository will have the same name as your fork.

```cd handson-2021-version-control```

The forked repository should be named as the “origin” remote, while the original project you wish to contribute is known as the “upstream” remote. The “origin” remote should have been set automatically as you cloned the fork, but you will need to add the “upstream” repository.
```git remote -v``` 
```git remote add upstream https://github.com/evalancaster/handson-2021-version-control```

You will only need to clone when first creating the local repository. Once established, you can just pull down any updates to ensure you are working with the most recent version.

```git pull upstream master```

It is generally good practice to create a separate branch from the “master” to make edits in. This structure allows you to continually pull updates from the master branch while working on your own modifications.

```git checkout -b learn-collab```

Your new branch name should be informative about the modifications you intend to make. Here, the new branch is named learn-collab because we are completing this exercise in order to learn how to use Git collaboratively. Running git branch will show that you have a master branch, but that you are currently working on (or have checked out) the “learn-collab” branch. Your checked out branch is denoted by an asterisk.


3. **Make edits to the repository, stage and then commit your changes.** Open one of the project files and make an edit to the text. Add this modified file to the staging area and commit your changes with a meaningful message. 

```git add -A```

```git commit -m "describe rationale for changes here"```


4. **Push changes.** You can now push the changes to origin (your forked remote repository on GitHub). After pushing the branch that contains your modifications, return to your forked repository (origin) on GitHub to see the push notice.

```git push origin learn-collab```


5. **Submit a pull request.** Now that you have made your contribution, you can submit the modified project to the upstream repository. To notify the owner of your changes you must submit a pull request. The administrator can then decide whether to merge your changes into the original repository. If your changes are merged, GitHub will notify you and prompt you to delete the branch containing those edits. This deletes the branch from the origin repository, but you will have to manually delete it from your local repository as well.

```git checkout master```

```git branch -D learn-collab```


After you have your project set up, you can continue making contributions by pulling down the most recent version of the repository, creating a new branch, and pushing your changes. To synchronize all personal repositories with the upstream repository, first pull from the upstream repository to your local computer, and then push that latest version to your origin repository.

```git pull upstream master```

```git push origin master```

