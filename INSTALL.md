#Install notes#


On linux:
(Tested on fedora 21)


1 Set default provider.
Otherwise it will try to build for libvirt.


```Shell
export VAGRANT_DEFAULT_PROVIDER=virtualbox
```
in .bashrc

ENV['VAGRANT_DEFAULT_PROVIDER'] = 'virtualbox' in vagrantfile.


2 Enable ssh agent forwarding.
  ```Shell
  cd ~/.ssh
  Host 192.168.10.16
   ForwardAgent yes
  Host 192.168.10.18
   ForwardAgent yes
  ```

3 Optionally: change MEMSIZE in the vagrantfile.
  You can increase memory in virtualbox later when needed, but if you have more RAM
  increasing may speed up the build process.
  Suggested value: 2048 on a 8G system.

4 Run make
  ```Shell
  make
  ```

5 Troubleshooting:
Sometimes you will have to manually remove the directory for the virtualbox machine
directory after build failures.

Check /var/log/boot.log inside the virtual servers for startup errors.

See also:
https://github.com/Hruodland/buildserver/wiki/Trouble-shooting

The last test of getting the war file from dev may fail.
This may be related to the minimal amount of memory.

1 Jenkins is not finished bulding at that point in time.
2 Sometimes the build fails, it cannot contact nexus, first open a web page to nexus then try a
  rebuild in Jenkins and wait for a green light for the build.
3 Then manually run the last line of the deploy step from the Makefile.


