all : libfizzbuzz.so

libfizzbuzz.so : libfizzbuzz.go
	go build -buildmode=c-shared -o libfizzbuzz.so libfizzbuzz.go
