# Building tarballs

The `build.sh` script will output the tarballs into the `/tmp/build` folder, and
output their paths. The output is in zip and tar.gz.

If you have the link for the releases notes, you can export the below variable
before the build execution:

```bash
export TAG=<engine tag>
export EXTTAG=<extensions tag>
./build.sh
```

The link for the release notes can be found in the website pull requests
as of the moment.
