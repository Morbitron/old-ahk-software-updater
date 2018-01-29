#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
;SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.


;commandline = a "file.7z"  "7z.exe"

;7zip(commandline)



7zip(commandline)
{
	RunWait, "7z.exe" %commandline%,,Hide, result
	return result
}


7zipAdd(archive, file, options="")
{
	commandline = a %options% "%archive%" "%file%"
	RunWait, "7z.exe" %commandline%,,Hide, result
	return result
}

;7zipExtract("archive.7z", "folder_name")
7zipExtract(archive, directory="-o*", options="")
{
	if(directory != "-o*")
		directory := "-o" . directory
	
	commandline = x %options% "%archive%" "%directory%"
	RunWait, "7z.exe" %commandline%,,Hide, result
	return result
}











 
/*
7-Zip 18.00 beta (x64) : Copyright (c) 1999-2018 Igor Pavlov : 2018-01-10

Usage: 7z <command> [<switches>...] <archive_name> [<file_names>...]

<Commands>
  a : Add files to archive
  b : Benchmark
  d : Delete files from archive
  e : Extract files from archive (without using directory names)
  h : Calculate hash values for files
  i : Show information about supported formats
  l : List contents of archive
  rn : Rename files in archive
  t : Test integrity of archive
  u : Update files to archive
  x : eXtract files with full paths

<Switches>
  -- : Stop switches parsing
  @listfile : set path to listfile that contains file names
  -ai[r[-|0]]{@listfile|!wildcard} : Include archives
  -ax[r[-|0]]{@listfile|!wildcard} : eXclude archives
  -ao{a|s|t|u} : set Overwrite mode
  -an : disable archive_name field
  -bb[0-3] : set output log level
  -bd : disable progress indicator
  -bs{o|e|p}{0|1|2} : set output stream for output/error/progress line
  -bt : show execution time statistics
  -i[r[-|0]]{@listfile|!wildcard} : Include filenames
  -m{Parameters} : set compression Method
    -mmt[N] : set number of CPU threads
    -mx[N] : set compression level: -mx1 (fastest) ... -mx9 (ultra)
  -o{Directory} : set Output directory
  -p{Password} : set Password
  -r[-|0] : Recurse subdirectories
  -sa{a|e|s} : set Archive name mode
  -scc{UTF-8|WIN|DOS} : set charset for for console input/output
  -scs{UTF-8|UTF-16LE|UTF-16BE|WIN|DOS|{id}} : set charset for list files
  -scrc[CRC32|CRC64|SHA1|SHA256|*] : set hash function for x, e, h commands
  -sdel : delete files after compression
  -seml[.] : send archive by email
  -sfx[{name}] : Create SFX archive
  -si[{name}] : read data from stdin
  -slp : set Large Pages mode
  -slt : show technical information for l (List) command
  -snh : store hard links as links
  -snl : store symbolic links as links
  -sni : store NT security information
  -sns[-] : store NTFS alternate streams
  -so : write data to stdout
  -spd : disable wildcard matching for file names
  -spe : eliminate duplication of root folder for extract command
  -spf : use fully qualified file paths
  -ssc[-] : set sensitive case mode
  -sse : stop archive creating, if it can't open some input file
  -ssw : compress shared files
  -stl : set archive timestamp from the most recently modified file
  -stm{HexMask} : set CPU thread affinity mask (hexadecimal number)
  -stx{Type} : exclude archive type
  -t{Type} : Set type of archive
  -u[-][p#][q#][r#][x#][y#][z#][!newArchiveName] : Update options
  -v{Size}[b|k|m|g] : Create volumes
  -w[{path}] : assign Work directory. Empty path means a temporary directory
  -x[r[-|0]]{@listfile|!wildcard} : eXclude filenames
  -y : assume Yes on all queries
*/


7zipHelp()
{
	MsgBox, ,  7-Zip Help, % "7-Zip 18.00 beta (x64) : Copyright (c) 1999-2018 Igor Pavlov : 2018-01-10\r\n\r\nUsage: 7z <command> [<switches>...] <archive_name> [<file_names>...]\r\n\r\n<Commands>\r\n  a : Add files to archive\r\n  b : Benchmark\r\n  d : Delete files from archive\r\n  e : Extract files from archive (without using directory names)\r\n  h : Calculate hash values for files\r\n  i : Show information about supported formats\r\n  l : List contents of archive\r\n  rn : Rename files in archive\r\n  t : Test integrity of archive\r\n  u : Update files to archive\r\n  x : eXtract files with full paths\r\n\r\n<Switches>\r\n  -- : Stop switches parsing\r\n  @listfile : set path to listfile that contains file names\r\n  -ai[r[-|0]]{@listfile|!wildcard} : Include archives\r\n  -ax[r[-|0]]{@listfile|!wildcard} : eXclude archives\r\n  -ao{a|s|t|u} : set Overwrite mode\r\n  -an : disable archive_name field\r\n  -bb[0-3] : set output log level\r\n  -bd : disable progress indicator\r\n  -bs{o|e|p}{0|1|2} : set output stream for output/error/progress line\r\n  -bt : show execution time statistics\r\n  -i[r[-|0]]{@listfile|!wildcard} : Include filenames\r\n  -m{Parameters} : set compression Method\r\n    -mmt[N] : set number of CPU threads\r\n    -mx[N] : set compression level: -mx1 (fastest) ... -mx9 (ultra)\r\n  -o{Directory} : set Output directory\r\n  -p{Password} : set Password\r\n  -r[-|0] : Recurse subdirectories\r\n  -sa{a|e|s} : set Archive name mode\r\n  -scc{UTF-8|WIN|DOS} : set charset for for console input/output\r\n  -scs{UTF-8|UTF-16LE|UTF-16BE|WIN|DOS|{id}} : set charset for list files\r\n  -scrc[CRC32|CRC64|SHA1|SHA256|*] : set hash function for x, e, h commands\r\n  -sdel : delete files after compression\r\n  -seml[.] : send archive by email\r\n  -sfx[{name}] : Create SFX archive\r\n  -si[{name}] : read data from stdin\r\n  -slp : set Large Pages mode\r\n  -slt : show technical information for l (List) command\r\n  -snh : store hard links as links\r\n  -snl : store symbolic links as links\r\n  -sni : store NT security information\r\n  -sns[-] : store NTFS alternate streams\r\n  -so : write data to stdout\r\n  -spd : disable wildcard matching for file names\r\n  -spe : eliminate duplication of root folder for extract command\r\n  -spf : use fully qualified file paths\r\n  -ssc[-] : set sensitive case mode\r\n  -sse : stop archive creating, if it can't open some input file\r\n  -ssw : compress shared files\r\n  -stl : set archive timestamp from the most recently modified file\r\n  -stm{HexMask} : set CPU thread affinity mask (hexadecimal number)\r\n  -stx{Type} : exclude archive type\r\n  -t{Type} : Set type of archive\r\n  -u[-][p#][q#][r#][x#][y#][z#][!newArchiveName] : Update options\r\n  -v{Size}[b|k|m|g] : Create volumes\r\n  -w[{path}] : assign Work directory. Empty path means a temporary directory\r\n  -x[r[-|0]]{@listfile|!wildcard} : eXclude filenames\r\n  -y : assume Yes on all queries"
}