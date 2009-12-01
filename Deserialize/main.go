package main

import "xml"
import "./file"
import "fmt"

type User struct 
{
	EmailAddress	string;
	Password	string;		
}


func main( )
{
	file, _ := file.Open( "./user.xml", 0, 0 );

	var result = User { "emailAddress", "password" };
	
	xml.Unmarshal( file, &result );

	fmt.Printf( "%s\n", result.EmailAddress );
	fmt.Printf( "%s\n", result.Password );
}
