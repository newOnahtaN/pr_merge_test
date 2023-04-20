echo feature:on > config.txt
git add * && git commit -am "Turned feature on for the first time"
git checkout -b topic/disableFeature
echo feature:off > config.txt
git commit -am "Turned off feature due to issue, will merge with main soon"
git checkout main && echo irrelevant-commit-change > a.txt && git add a.txt && git commit -am "Irrelevant change"
git merge topic/disableFeature
git checkout topic/disableFeature && git checkout -b topic/re-enableFeature
git merge main~
:: Main and topic/re-enableFeature are now in a criss-crossed state.
:: Merging from main~ is contrived for this example, similar merges happen in Office for different reasons that result in criss-crossed states
echo feature:on > config.txt && git commit -am "Feature was fixed so we are turning it back on"
git checkout main && echo another-irrelevant-commit-change > a.txt && git commit -am "Another irrelevant change"
git push -u origin head && git checkout topic/re-enableFeature && git push -u origin head

:: Now, manually open a PR from topic/disableFeature to main. A merge which takes into account all merge
:: bases will have the PR turn the feature back on. One that doesn't will make it look as if the change
:: that turns the feature back on is invisible.