package main

import (
	"C"
	"fmt"
)

var (
	c chan string
)

func init() {
	c = make(chan string)
	go func() {
		n := 1
		for {
			switch {
			case n%15 == 0:
				c <- "FizzBuzz"
			case n%3 == 0:
				c <- "Fizz"
			case n%5 == 0:
				c <- "Buzz"
			default:
				c <- fmt.Sprint(n)
			}
			n++
		}
	}()
}

//export fizzbuzz
func fizzbuzz(n int) *C.char {
	return C.CString(<-c)
}

func main() {
}
