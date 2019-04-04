## Debootstrap Ubuntu onto Microsoft Surface
### Not intended for general-purpose use

This is just a sketch that I used to debootstrap Linux from a USB install of Ubuntu. It's not intended for general purpose use: it makes a lot of assumptions about setup.

The original intent was to run Ubuntu in the machine's NTFS partition.  That did work, but it would not shut down properly, because the root drive was in use when shutting down.  The only way to get it to reboot was to SysRq+REISUB it.





