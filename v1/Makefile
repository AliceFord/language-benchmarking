main: 
	pyminifier python/code.py > python/out.py
	g++ -o cpp/noopt cpp/code.cpp
	g++ -o cpp/opt -O3 cpp/code.cpp
	javac java/Main.java
	cd rust/code && cargo build --release && cd.. && cd..
	"C:\Program Files\Go\bin\go.exe" build -o golang/code.exe golang/code.go
	python timer.py $(ITERATIONS)