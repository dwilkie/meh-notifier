# meh-notifer

## Installation/Update Instructions
1. Make sure your working on the master branch: `git checkout master`
2. Make your changes
3. Commit: `git commit -m "message"`
4. Switch to staging branch: `git checkout staging`
5. Merge changes from master: `git merge master`
6. To install new gems: Tweak the Gemfile (just add a space then delete it again)
7. Switch to ruby 1.8.7: `rvm 1.8.7`
8. Update to staging server: `appcfg.rb update .`
9. Switch back to default ruby: `rvm default`
10. Switch back to master: `git checkout master`

