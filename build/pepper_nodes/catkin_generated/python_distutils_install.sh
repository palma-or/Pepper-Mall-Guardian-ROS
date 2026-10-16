#!/bin/sh

if [ -n "$DESTDIR" ] ; then
    case $DESTDIR in
        /*) # ok
            ;;
        *)
            /bin/echo "DESTDIR argument must be absolute... "
            /bin/echo "otherwise python's distutils will bork things."
            exit 1
    esac
fi

echo_and_run() { echo "+ $@" ; "$@" ; }

echo_and_run cd "/home/giovanni/Desktop/Project_B/src/pepper_nodes"

# ensure that Python install destination exists
echo_and_run mkdir -p "$DESTDIR/home/giovanni/Desktop/Project_B/install/lib/python3/dist-packages"

# Note that PYTHONPATH is pulled from the environment to support installing
# into one location when some dependencies were installed in another
# location, #123.
echo_and_run /usr/bin/env \
    PYTHONPATH="/home/giovanni/Desktop/Project_B/install/lib/python3/dist-packages:/home/giovanni/Desktop/Project_B/build/pepper_nodes/lib/python3/dist-packages:$PYTHONPATH" \
    CATKIN_BINARY_DIR="/home/giovanni/Desktop/Project_B/build/pepper_nodes" \
    "/usr/bin/python3" \
    "/home/giovanni/Desktop/Project_B/src/pepper_nodes/setup.py" \
     \
    build --build-base "/home/giovanni/Desktop/Project_B/build/pepper_nodes" \
    install \
    --root="${DESTDIR-/}" \
    --install-layout=deb --prefix="/home/giovanni/Desktop/Project_B/install" --install-scripts="/home/giovanni/Desktop/Project_B/install/bin"
