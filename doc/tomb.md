# [Tomb](https://www.dyne.org/software/tomb/)

[Quickstart](https://github.com/dyne/Tomb/wiki/Quickstart)

Create a 100MB tomb:

```sh
mkdir -p ~/.secrets && cd ~/.secrets

tomb dig -s 100 mrpoppybutthole.tomb
tomb forge mrpoppybutthole.tomb.key
tomb lock secret.tomb -k mrpoppybutthole.tomb.key
```

Open it: `tomb open mrpoppybutthole.tomb -k mrpoppybutthole.tomb.key`

`tomb close` to unmount tomb.
