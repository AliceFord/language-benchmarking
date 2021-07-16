main: 
	g++ -o cpp/noopt cpp/code.cpp
	g++ -o cpp/opt -O3 cpp/code.cpp
	javac java/Main.java
	cd rust/code && cargo build --release && cd.. && cd..
	"C:\Program Files\Go\bin\go.exe" build -o golang/code.exe golang/code.go
	gfortran fortran/code.f90 -o fortran/code
	C:\D\dmd2\windows\bin\dmd.exe -of=D/noopt D/code.d
	C:\D\dmd2\windows\bin\dmd.exe -of=D/opt -O -release -inline -boundscheck=off D/code.d
	python -u timer.py $(ITERATIONS)

clean:
	del /s *.exe
