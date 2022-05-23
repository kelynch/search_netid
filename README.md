# README for `search_netid`

This script harvests and outputs available net IDs from [Princeton's Advanced People Search](https://www.princeton.edu/search/people-advanced) based on names in a manifest.

## Instructions

1. Create a manifest formatted like [manifest.example](manifest.example), with one name per line, first name then last name, as follows:

```
Gerard Spivey
Jessica Watson
Zhi Ma
Laurene Bonneville
Melibeo Callas
...
```
2. Run the script as follows:

```bash
$ ruby search_netid.rb
```

3. You should see output something like the following:

```bash
gspivey
jw123
zhima
N/A
mc456
```

NOTE: If a name does not have a net ID associated with it in the Advanced People Search, the script will print `N/A`.
