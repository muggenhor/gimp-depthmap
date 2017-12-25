CC?=gcc
GIMPTOOL=gimptool-2.0
GIMP_CFLAGS=$(shell $(GIMPTOOL) --cflags)
GIMP_LIBS=$(shell $(GIMPTOOL) --libs)
CV_CFLAGS=$(shell pkg-config --cflags opencv)
CV_LIBS=$(shell pkg-config --libs opencv)
CFLAGS=-O3
PLUGIN=elsamuko-depthmap

RM=rm -f

all: $(PLUGIN)

$(PLUGIN): $(PLUGIN).o
	$(CC) $^ -o $@ -B static $(CV_LIBS) -B dynamic $(GIMP_LIBS) $(LDFLAGS)

install: $(PLUGIN)
	$(GIMPTOOL) --install-admin-bin $^

userinstall: $(PLUGIN)
	$(GIMPTOOL) --install-bin $^

%.o: %.c
	$(CC) $(CV_CFLAGS) $(GIMP_CFLAGS) $(CFLAGS) -c $<

clean:
	$(RM) $(PLUGIN).o $(PLUGIN)

.PHONY: all install userinstall clean
