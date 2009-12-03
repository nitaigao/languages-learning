package main

import "rpc"
import "http"
import "net"
import "fmt"

func main( )
{
	rpc.HandleHTTP();

	l, _ := net.Listen("tcp", ":8089");
	http.Serve(l, http.HandlerFunc( handleRequest ) );
}

func handleRequest(c *http.Conn, req *http.Request) 
{
	fmt.Printf( "Request Received\n" );
}
