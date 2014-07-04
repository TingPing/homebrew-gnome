Homebrew-Gnome
--------------

This repo contains a few extra packages from the gnome project.
It may also contain a few non-gnome packages that depend on these packages.

It also contains versions of gtk+ built against the Quartz backend instead of X11.
Note that these conflict with the main homebrew repo.

Using
-----

```
brew tap TingPing/gnome
brew install TingPing/gnome/gtk+3
```

To get the best gtk experience follow these steps:

- Install:
    ```
    gnome-icon-theme* gnome-themes-standard gtk-quartz-engine
    ```

- Set themes
    - *~/.config/gtk-3.0/settings.ini*:

        ```ini
        [Settings]
        gtk-theme-name = Adwaita
        ```

    - *~/.gtkrc-2.0*:

        ```ini
        gtk-theme-name = "Quartz"
        ```

- Set up gtk environment variables:
    ```sh
    # HOMEBREW_PREFIX would be /usr/local by default.
    export XDG_DATA_DIRS="$HOMEBREW_PREFIX/share"
    export XDG_CONFIG_DIRS="$HOMEBREW_PREFIX/etc"
    export XDG_CONFIG_HOME="$HOME/.config"
    export GSETTINGS_SCHEMA_DIR="$HOMEBREW_PREFIX/etc/glib-2.0/schemas"
    export GTK_DATA_PREFIX="$HOMEBREW_PREFIX"
    export GTK_EXE_PREFIX="$HOMEBREW_PREFIX"
    export GTK_PATH="$HOMEBREW_PREFIX"
    export PANGO_LIBDIR="$HOMEBREW_PREFIX/lib"
    export PANGO_SYSCONFDIR="$HOMEBREW_PREFIX/etc"
    export GDK_PIXBUF_MODULEDIR="$HOMEBREW_PREFIX/lib/gdk-pixbuf-2.0/2.10.0/loaders"
    export GDK_PIXBUF_MODULE_FILE="$HOMEBREW_PREFIX/etc/gtk-2.0/gdk-pixbuf.loaders"
    ```

- Update various cache files:
    ```sh
    glib-compile-schemas --targetdir=$GSETTINGS_SCHEMA_DIR $HOMEBREW_PREFIX/share/glib-2.0/schemas
    gdk-pixbuf-query-loaders --update-cache
    ```
