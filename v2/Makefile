main: cpp/noopt.exe cpp/opt.exe java/Main.class rust/code/target/release/code.exe golang/code.exe fortran/code.exe D/noopt.exe D/opt.exe assembly/code
	python -u timer.py $(ITERATIONS)

cpp/noopt.exe:
	g++ -o cpp/noopt cpp/code.cpp

cpp/opt.exe:
	g++ -o cpp/opt -O3 cpp/code.cpp

java/Main.class:
	javac java/Main.java

rust/code/target/release/code.exe:
	cd rust/code && cargo build --release && cd.. && cd..

golang/code.exe:
	"C:\Program Files\Go\bin\go.exe" build -o golang/code.exe golang/code.go

fortran/code.exe:
	gfortran fortran/code.f90 -o fortran/code

D/noopt.exe:
	C:\D\dmd2\windows\bin\dmd.exe -of=D/noopt D/code.d

D/opt.exe:
	C:\D\dmd2\windows\bin\dmd.exe -of=D/opt -O -release -inline -boundscheck=off D/code.d

assembly/code:
	wsl --cd "C:/users/olive/desktop/coding/speedtests/v2/assembly" gcc -no-pie -o code code.s

clean:
	del /s *.exe
