package hello

import (
	"bytes";
	"testing";
)

func TestSayHello(t *testing.T) {
        out := new(bytes.Buffer);
	SayHello(out);
	checkString(t, "unexpected greeting", "hello, world\n", out.String());
}

func checkString(t *testing.T, message, expected, actual string) {
	if expected != actual {
		t.Errorf("%s: '%s' != '%s'", message, expected, actual);
        }
}
