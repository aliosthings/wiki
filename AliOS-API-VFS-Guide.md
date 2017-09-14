------
# 1 VFS API
## 1.1 aos_open()
> * int aos_open(const char *path, int flags)
> > - [x] Open the file or device by its path
> > - [x] ************Parameters:************

    [in]  path   the path of the file or device you want to open

    [in]  flags  the mode of open operation
> > - [x] ************Returns:************
       the new file descriptor, negative error on failure

## 1.2 aos_close()
> * int aos_close(int fd)
> > - [x] Close the file or device by its fd
> > - [x] ************Parameters:************

    [in]  fd  the handle of the file or device
> > - [x] ************Returns:************
       0 on success, negative error on failure

## 1.3 aos_read()
> * ssize_t aos_read(int fd, void *buf, size_t nbytes)
> > - [x] Read the contents of a file or device into a buffer
> > - [x] ************Parameters:************

    [in]   fd      the handle of the file or device

    [in]   nbytes  the number of bytes to read

    [out]  buf     the buffer to read into
> > - [x] ************Returns:************
       The number of bytes read, 0 at the end of file, negative error on failure

## 1.4 aos_write()
> * ssize_t aos_write(int fd, const void *buf, size_t nbytes)
> > - [x] Write the contents of a buffer to file or device
> > - [x] ************Parameters:************

    [in]  fd      the handle of the file or device

    [in]  nbytes  the number of bytes to write

    [in]  buf     the buffer to write from
> > - [x] ************Returns:************
       The number of bytes written, negative error on failure

## 1.5 aos_ioctl()
> * int aos_ioctl(int fd, int cmd, unsigned long arg)
> > - [x] This is a wildcard API for sending controller specific commands
> > - [x] ************Parameters:************

    [in]  fd   the handle of the file or device

    [in]  cmd  a controller specific command

    [in]  arg  argument to the command, interpreted according to the command
> > - [x] ************Returns:************
       Any return from the command

## 1.6 aos_poll()
> * int aos_poll(struct pollfd *fds, int nfds, int timeout)
> > - [x] A mechanism to multiplex input/output over a set of file handles(file descriptors)  
          For every file handle provided, poll() examines it for any events registered for that particular file handles
> > - [x] ************Parameters:************

    [in]  fds      a point to the array of PollFh struct carrying a file handle and bitmask of events

    [in]  nfds     number of file handles

    [in]  timeout  timer value to timeout or -1 for loop forever
> > - [x] ************Returns:************
       Number of file handles selected (for which revents is non-zero). 0 if timed out with nothing selected. -1 for error.

## 1.7 aos_fcntl()
> * int aos_fcntl(int fd, int cmd, int val)
> > - [x] Performs one of the operations described below on the open file descriptor, The operation is determined by cmd
> > - [x] ************Parameters:************

    [in]  fd   the handle of the file or device

    [in]  cmd  the operation of the file or device

    [in]  val  it depends on whether cmd need params
> > - [x] ************Returns:************
       0 on success, negative error on failure

## 1.8 aos_lseek()
> * off_t aos_lseek(int fd, off_t offset, int whence)
> > - [x] Move the file position to a given offset from a given location
> > - [x] ************Parameters:************

    [in]  fd      file handle

    [in]  offset  the offset from whence to move to

    [in]  whence  the start of where to seek
> > - [x] ************Returns:************
       The new offset of the file

## 1.9 aos_sync()
> * int aos_sync(int fd)
> > - [x] Flush any buffers associated with the file
> > - [x] ************Parameters:************

    [in]  fd  file handle
> > - [x] ************Returns:************
       0 on success, negative error code on failure

## 1.10 aos_stat()
> * int aos_stat(const char *path, struct stat *st)
> > - [x] Store information about the file in a stat structure
> > - [x] ************Parameters:************

    [in]  path  the name of the file to find information about

    [in]  st    the stat buffer to write to
> > - [x] ************Returns:************
       0 on success, negative error code on failure

## 1.11 aos_unlink()
> * int aos_unlink(const char *path)
> > - [x] Remove a file from the filesystem
> > - [x] ************Parameters:************

    [in]  path  the name of the file to remove
> > - [x] ************Returns:************
       0 on success, negative error code on failure

## 1.12 aos_rename()
> * int aos_rename(const char *oldpath, const char *newpath)
> > - [x] Rename a file in filesystem
> > - [x] ************Parameters:************

    [in]  oldpath  the name of the file to rename

    [in]  newpath  the name to rename it to
> > - [x] ************Returns:************
       0 on success, negative error code on failure

## 1.13 aos_opendir()
> * aos_dir_t *aos_opendir(const char *path)
> > - [x] Open a directory on the filesystem
> > - [x] ************Parameters:************

    [in]  path  name of the directory to open
> > - [x] ************Returns:************
       A point of directory stream on success, NULL on failure

## 1.14 aos_closedir()
> * int aos_closedir(aos_dir_t *dir)
> > - [x] Close a directory
> > - [x] ************Parameters:************

    [in]  dir  directory handle
> > - [x] ************Returns:************
       0 on success, negative error code on failure

## 1.15 aos_readdir()
> * aos_dirent_t *aos_readdir(aos_dir_t *dir)
> > - [x] Read the next directory enter
> > - [x] ************Parameters:************

    [in]  dir  directory handle
> > - [x] ************Returns:************
       a pointer to a dirent structure

## 1.16 aos_mkdir()
> * int aos_mkdir(const char *path)
> > - [x] Create the directory, if they do not already exist
> > - [x] ************Parameters:************

    [in]  path  the name of the directory
> > - [x] ************Returns:************
       0 on success, negative error code on failure
------