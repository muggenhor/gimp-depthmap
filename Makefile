
CXX=gcc
GIMPTOOL=gimptool-2.0
GIMP_FLAGS=`$(GIMPTOOL) --cflags`
GIMP_LIBS=`$(GIMPTOOL) --libs`
CV_FLAGS=`pkg-config --cflags opencv`
CV_LIBS=`pkg-config --libs opencv`
FLAGS=-O3

RM=rm -f

all: elsamuko-depthmap-cv

elsamuko-depthmap-cv: elsamuko-depthmap-cv.o
	$(CXX) $(CV_FLAGS) $(FLAGS) $(GIMP_FLAGS) elsamuko-depthmap-cv.o -o elsamuko-depthmap-cv -B static $(CV_LIBS) -B dynamic $(GIMP_LIBS)
	$(GIMPTOOL) --install-bin elsamuko-depthmap-cv

elsamuko-depthmap-cv.o: elsamuko-depthmap-cv.c
	$(CXX) $(CV_FLAGS) $(FLAGS) $(GIMP_FLAGS) -c elsamuko-depthmap-cv.c -Wl,-static $(CV_LIBS) -Wl,-dynamic $(GIMP_LIBS)

clean:
	$(RM) elsamuko-depthmap-cv.o elsamuko-depthmap-cv *~
