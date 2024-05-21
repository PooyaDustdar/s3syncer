#! /bin/bash

# init
mc alias set $S3_ALIAS $S3_URL $S3_ACCESSKEY $S3_SECRETKEY
if [ -z "$1" ]; then
    fswatch -o $WATCH_DIR | xargs -n1 -I{} mc mirror --overwrite --remove --preserve --retry $WATCH_DIR $S3_ALIAS/$S3_BUCKET
else
    cmd=$1
    case "$cmd" in
        resync)
            if [ -z "$2" ]; then
                mc mirror --overwrite --remove --preserve --retry $WATCH_DIR $S3_ALIAS/$S3_BUCKET
            else
                echo "uploading "$WATCH_DIR"/"$2
                mc put $WATCH_DIR/$2 $S3_ALIAS/$S3_BUCKET/$2
            fi
            exit 1
            ;;
        reverse)
            mc mirror --overwrite --remove --preserve --retry $S3_ALIAS/$S3_BUCKET $WATCH_DIR
            ;;
        *)
            echo "error in arguments"
            ;;
    esac
fi