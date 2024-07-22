lua-test
========

This is a sample lua script for testing how fast lua can run when executed with luajit.

Seems pretty dang fast.

> [!NOTE]  
> Only works on machines with `tput` available, as the script calls tput for querying terminal size and setting cursor position

How to run
----------

```bash
luajit main.lua
```

How to run tests
----------------

```bash
luajit main.lua test
```

