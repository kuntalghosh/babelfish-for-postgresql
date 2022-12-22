# Releasing tarballs

The `release.sh` script will create a draft release for the input TAG.  You must
create the TAG in https://github.com/babelfish-for-postgresql/babelfish-for-postgresql/tags
before executing this script.

You also need to provide the location of tarballs that should be attached to the
release.

```bash
export TAG=<Release Tag>
export LOC=<Attachment Location>
./release.sh
```
