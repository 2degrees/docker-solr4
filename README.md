# Docker Image for Solr v4

**Warning** This project is no longer actively maintained.

This is Docker image allows you to run Solr v4 with the default Jetty server
in a multi-core setup. To use it, simply place your core directory in the Solr
home; e.g.:

    docker run \
        -p 127.0.0.1:8983:8983 \
        -v /etc/your-awesome-core:/etc/opt/solr/cores/your-awesome-core:ro \
        2degrees/solr4

Alternatively, you could extend this image and ship the new one with the core
directory included.

Use the official Solr image if you need newer versions of Solr.


## Adding Cores

Solr can auto-discover cores anywhere in its home directory, but the `cores`
sub-directory is recommended.

The `example` directory in the Solr distribution is preserved in case you want
to configure your core(s) dynamically using any file in there. For example,
you may want to copy `solrconfig.xml` and alter the copy in-place (with `patch`
or `sed`, for example), instead of maintaining a modified copy of the whole
file.

You are able to mount the core directories in read-only mode, as the indices
are kept outside.


## Relevant Directories

If you need to refer to any of the paths below, use the corresponding
environment variable where possible.

- Solr Home (`${SOLR_HOME_PATH}`): `/etc/opt/solr`
- Solr Distribution (`${SOLR_DISTRIBUTION_PATH}`): `/opt/solr`
- Jetty Home (`${JETTY_HOME_PATH}`): `/etc/opt/jetty`
- Solr indices (`${SOLR_INDICES_DIR_PATH}`): `/var/opt/solr/indices`


## The `solr` Command

This is the default command, and it runs the web server in the foreground with
some default, run-time arguments for the Java VM, Jetty and Solr. Any additional
arguments to this script, such as property definitions, will be passed on to
the JVM.

If you place any limit on the memory for the container, the JVM's heap memory
will be configured accordingly so that you only have to manage memory
allocation from Docker. To enable this, just add the `--memory=X` option to
`docker run` or the equivalent in Docker Compose.

This script is meant as a replacement for `${SOLR_DISTRIBUTION_PATH}/bin/solr`
because the latter does not propagate signals (e.g., `SIGTERM`) to the JVM,
meaning that `docker stop` wouldn't actually stop the container.


## Building from a Different Mirror

If you're contributing changes to this project, you may optionally specify a
custom mirror with the build argument `mirror_url`. A local mirror will build
the image in a matter of seconds instead of minutes.

For example:

    docker build \
        --tag=solr4 \
        --build-arg mirror_url=http://example.com/solr-mirror \
        .

Note the absence of a trailing slash in the URL. The example above assumes that
the URL to the Solr distribution archive is
`http://example.com/solr-mirror/solr-4.X.Y.tgz`.
