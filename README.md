## Megatools in docker

Megatools installed on debian image.

Why? Because megatools are available as debian package only in sid.
If you are not running on sid, then you are forced to compile yourself.

## Usage

This image is meant to be used from CLI.

You will have to provide mega credentials on each docker run.
It can be done as arguments in mega* commands.

Or in configuration file `~/.megarc`.
```
[Login]
Username = your@email
Password = yourpassword
```

If you keep your configuration file in home of the docker host,
then any mega command can be run with:
```
docker run -ti --rm -v=$HOME/.megarc:/.megarc tomzo/megatools-docker <COMMAND>
```

To verify that your configuration is working you can run
```
docker run -ti --rm -v=$HOME/.megarc:/.megarc tomzo/megatools-docker megadf
```

### Example

Uploading `$HOME/myfiles` folder using docker volumes and the `/bin/megaupload` script.

```
docker run -ti --rm -v=$HOME/.megarc:/.megarc -v=$HOME/myfiles:/Root tomzo/megatools-docker /bin/megaupload
```

## Synchronization

Megatools do not support synchronization of folders. The `megafs` allows
only read-only mount. `megaupload` uploads only new files.

In this container you can find **very simple** `megasync` script.
It allows to upload files and folders and **delete** ones that no longer exist locally.
It fits into use cases when all files are **immutable**.

**WARNING: do not use this on important data, this script does DELETE files and folder in your MEGA account**

Example use - synchronize `/tmp/myfiles` with remote directory `/Root/mysync`:
```
docker run -ti --rm -v=$HOME/.megarc:/.megarc -v='/tmp/myfiles:/Root/mysync' tomzo/megatools-docker /bin/megasync mysync
```

## Links
 * online man pages http://megatools.megous.com/man/megatools.html
