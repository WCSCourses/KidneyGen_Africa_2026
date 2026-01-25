## Linux Basic Commands Cheat Sheet

### File and directory navigation
| Command | Description | Example |
|-------|-------------|---------|
| `pwd` | Show current working directory | `pwd` |
| `ls` | List files and directories | `ls -lh` |
| `cd` | Change directory | `cd /home/user` |
| `tree` | Show directory tree | `tree` |

### File and directory management
| Command | Description | Example |
|-------|-------------|---------|
| `mkdir` | Create a directory | `mkdir data` |
| `rmdir` | Remove empty directory | `rmdir data` |
| `rm` | Remove files or directories | `rm -r old_data` |
| `cp` | Copy files or directories | `cp file.txt backup/` |
| `mv` | Move or rename files | `mv old.txt new.txt` |
| `touch` | Create empty file | `touch notes.txt` |

### Viewing and inspecting files
| Command | Description | Example |
|-------|-------------|---------|
| `cat` | Display file content | `cat file.txt` |
| `less` | View file page by page | `less file.txt` |
| `head` | Show first lines of a file | `head -n 10 file.txt` |
| `tail` | Show last lines of a file | `tail -n 10 file.txt` |

### Searching and filtering
| Command | Description | Example |
|-------|-------------|---------|
| `grep` | Search text in files | `grep "rsID" data.txt` |
| `find` | Search for files | `find . -name "*.vcf"` |
| `wc` | Count lines, words, characters | `wc -l file.txt` |
| `sort` | Sort file content | `sort data.txt` |
| `uniq` | Remove duplicate lines | `uniq sorted.txt` |

### File permissions and ownership
| Command | Description | Example |
|-------|-------------|---------|
| `chmod` | Change file permissions | `chmod 644 file.txt` |
| `chown` | Change file owner | `chown user file.txt` |
| `ls -l` | Show permissions | `ls -l` |

### Disk and system information
| Command | Description | Example |
|-------|-------------|---------|
| `df` | Disk space usage | `df -h` |
| `du` | Directory size | `du -sh data/` |
| `free` | Memory usage | `free -h` |
| `top` | Running processes | `top` |
| `htop` | Enhanced process viewer | `htop` |

### Compression and archiving
| Command | Description | Example |
|-------|-------------|---------|
| `tar` | Archive files | `tar -czvf files.tar.gz data/` |
| `gzip` | Compress file | `gzip file.txt` |
| `gunzip` | Decompress file | `gunzip file.txt.gz` |
| `zip` | Zip files | `zip data.zip data/*` |
| `unzip` | Unzip archive | `unzip data.zip` |

### Networking and downloads
| Command | Description | Example |
|-------|-------------|---------|
| `wget` | Download files | `wget https://example.com/file` |
| `curl` | Transfer data from URLs | `curl -O https://example.com/file` |
| `ping` | Test network | `ping google.com` |

### Package management (Ubuntu/Debian)
| Command | Description | Example |
|-------|-------------|---------|
| `apt update` | Update package lists | `sudo apt update` |
| `apt upgrade` | Upgrade packages | `sudo apt upgrade` |
| `apt install` | Install packages | `sudo apt install bedtools` |
| `apt remove` | Remove packages | `sudo apt remove bedtools` |

### Environment and variables
| Command | Description | Example |
|-------|-------------|---------|
| `env` | Show environment variables | `env` |
| `export` | Set environment variable | `export PATH=$PATH:/tool/bin` |
| `which` | Locate executable | `which plink` |

### Command history and help
| Command | Description | Example |
|-------|-------------|---------|
| `history` | Show command history | `history` |
| `man` | Command manual | `man grep` |
| `--help` | Command help | `plink --help` |

### Useful shortcuts
| Shortcut | Description |
|--------|-------------|
| `Tab` | Auto-complete |
| `Ctrl + C` | Stop running command |
| `Ctrl + D` | Exit shell |
| `Ctrl + R` | Search command history |
