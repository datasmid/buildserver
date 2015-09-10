# ansible-ant

Install Ant in latest version from upstream.


# Role variables

## ant_version_major

Default: 1

## ant_version_minor

Default: 9

## ant_version_patch

Default: 4

## ant_mirror

Configure the mirror to download Ant.
Default: http://mirror.ox.ac.uk/sites/rsync.apache.org/ant/binaries/

## ant_redis_shad256sum

SHA512 sum for the downloaded Ant redistributable package.
Default: ee13c915a18f3c6e1283c43ce3716e2ed1b03fd87abe27d0e4964a84cba54474f95655c8d75ee12de2516f4df62402acfc9df064aa05f2cc80560a144b2128f8


## ant_bin_path

Directory where to symlink the ant binary to.
Default: /usr/local/bin


# Dependencies

None.


# License

Apache Version 2.0


# Author

Rob Dyke @robdyke.com opengpsoc.org
Based on ansible-maven by Mark Kusch @mark.kusch silpion.de


<!-- vim: set ts=4 sw=4 et nofen: -->
