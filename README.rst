libsh
==============================================================================

*"lib shell"*

Shell function include subsystem, with sample function library

| scott@smemsh.net
| https://github.com/smemsh/libsh/
| https://spdx.org/licenses/GPL-2.0


Description
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Selectively import individual functions or groups of related
functions into the shell environment, without having to track
dependencies, source file location, or source order.

Krufty collection of shell functions provided (collected by
author for his own projects).  None of them are necessary, or
very interesting; only the single ``include`` file is needed to
start your own library.


Interface
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

:require: import single function from the library (single file)
:include: import group of related functions (entire directory)


Usage
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#. source the ``include`` file from your script
#. place all library functions in subdirs of this file's location

   - use one file per function, (add symlinks for each func name if more)
   - each source file name corresponds to a ``require`` (single file sourced)
   - each subdirectory corresponds to an ``include`` (all in dir are sourced)

#. use ``include`` and ``require`` within libs to declare interdependencies


Example
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

::

    $ git clone -q https://github.com/smemsh/libsh ~/lib/sh

    $ cat << . > test.sh
    source ~/lib/sh/include
    include time setenv
    require field pidenv
    setenv now $(fecho time_t_to_timefmt `date +%s`)
    echo "$(now) is $now for window $(field = 2 <<< $(pidenv $$ WINDOWID))"
    .

    $ bash test.sh
    20160108120010 is 20160108120010 for window 4194311

..


Status
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

- used for many of author's personal projects
- code in here is old; bash-1.14.7 was released version when started
- some code might be broken or suboptimal, but much is in active use
- not all code generalized; some doesn't belong here; working to split out
- no other known users at this time (please notify author!)


Rationale
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

- The interface requires sourcing only one stub file (which can be
  located anywhere), to install the 'include' and 'require'
  functions in the shell's execution context.  This then makes
  everything else available selectively, by the use of these keywords
  in a script.

- Obviates need to impose an initialization order on the sourcing of
  shell startup files.  The order will be self-imposed as
  dependencies are automatically resolved.

- Removes the problem of deciding which functions from a library are
  worth exporting to child environments.  Instead we can simply
  export none of them; all inclusion is upon request only:
  preconfigured groups of commands can be requested with ``include``
  and single commands can be requested with ``require``

- Protects against redundant inclusion.  Early termination of
  include procedures if already defined.  This can be implemented
  wholly: per include; or partially: per function (i.e. requires).

- Potential for automatic generation and maintenance.  The list of
  functions provided by a source file can be determined from bash
  itself.

- Allows standalone executable scripts to participate in the system
  as well as forked children that have sourced login/profile
  scripts.  Sometimes the use of standalone scripts to provide
  simple commands is preferable to the use of functions.

- Code reuse and all the usual good reasons for having libraries.
