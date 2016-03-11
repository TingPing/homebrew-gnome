Homebrew-Gnome
--------------

This repo contains a few extra packages from the gnome project.
It may also contain a few non-gnome packages that depend on these packages
or personal packages I use.

#### NOTE: This repo is unmaintained at this time.

Using
-----

```
brew tap TingPing/gnome
```

Where possible I avoid repackaging things in the main repo. This comes with some issues though;
Homebrew has some issues handling ```--without-x11```. For many packages such as cairo or gtk+3
you will have to use that flag yourself and manually install them. There is no exaustive list
of these but if you get an XQuartz error that is what you must do. If this still does not work
Try following the steps mentioned in this [issue #5](https://github.com/TingPing/homebrew-gnome/issues/5#issuecomment-74783561)

Read the [wiki](https://github.com/TingPing/homebrew-gnome/wiki) for more information
on configuration you will need for things such as proper theming.
