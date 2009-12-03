// Copyright 2009 The Go Authors. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

package file

import (
	"os";
	"io";
	"bytes";
)

type File struct {
	name    string; // file name at Open time
	buffer	*bytes.Buffer;
}

func Open(name string, mode int, perm int) (file *File, err os.Error) {
	fileBytes, err := io.ReadFile( name );
	var buff = bytes.NewBuffer( fileBytes );

	return &File { name, buff }, err;
}

func (file *File) Read(b []byte) (ret int, err os.Error) {
	
	r, err := file.buffer.Read( b );
	return int(r), err;
}

func (file *File) String() string {
	return file.name
}
