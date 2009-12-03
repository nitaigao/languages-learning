package main

import (
	"net";
	"fmt";
	"bytes";
	"strings";
	"io";
	)


func main( )
{
	listener, err := net.Listen("tcp", "192.168.148.128:80" );

	if ( listener == nil )
	{
		fmt.Printf( "%s\n", err.String( ) );
	}

	conn, err := listener.Accept( );

	if ( conn == nil )
	{
		fmt.Printf( "%s\n", err.String( ) );
	}

	var data [1024]byte;
	conn.Read( &data );
        stringData := bytes.NewBuffer( &data ).String( );
        fmt.Printf( "%s", stringData );

	urls := strings.Split( stringData, " ", 0 );
	fmt.Printf( "%s\n", urls[ 1 ] );

	requestedFile, err := io.ReadFile( "." + urls[ 1 ] );

	var sendData *bytes.Buffer = new( bytes.Buffer );	
	sendData.WriteString( "HTTP/1.1 200 OK\r\n" );
	sendData.WriteString( "Date: Mon, 23 May 2009 22:38:34 GMT\r\n" );
	sendData.WriteString( "Accept-Ranges: bytes\r\n" );
	sendData.WriteString( "Content-Type: text/html; charset=UTF-8\r\n" );
	sendData.WriteString( "Connection: close\n" );
	sendData.WriteString( "Content-Length: 1100\r\n\r\n" );
	sendData.WriteString( bytes.NewBuffer( requestedFile ).String( ) );

	//sendData.WriteString( "Hello World" );
	
	conn.Write( sendData.Bytes( ) );

	fmt.Printf( "%s\n", sendData.String( ) );
}
