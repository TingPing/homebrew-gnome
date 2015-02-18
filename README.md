Homebrew-Gnome
--------------

This repo contains a few extra packages from the gnome project.
It may also contain a few non-gnome packages that depend on these packages
or personal packages I use.

Using
-----

```
brew tap TingPing/gnome
# If you previously installed gtk with x11, reinstall without it:
brew install gtk+3 --without-x11
```

Read the [wiki](https://github.com/TingPing/homebrew-gnome/wiki) for more information
on configuration you will need for things such as proper theming.
