-include ../mk/platform.mk

SOURCES := $(wildcard src/*.cpp)
OBJS_FILENAMES_DEBUG := $(patsubst src/%.cpp,Obj/%.o,$(SOURCES))
OBJS_FILENAMES := $(filter-out Obj/debug_new.o,$(OBJS_FILENAMES_DEBUG))

ifdef WIN32
DEPS := -DWPCAP -DHAVE_REMOTE
endif
ifdef LINUX
DEPS := -DLINUX
endif
ifdef MAC_OS_X
DEPS := -DMAC_OS_X
endif

INCLUDES := -I"./src" \
			-I"./header"
			
ifdef WIN32
INCLUDES += -I$(MINGW_HOME)/include/ddk \
			-I$(WINPCAP_HOME)/Include
endif
ifdef LINUX
INCLUDES += -I/usr/include/netinet
endif
ifdef MAC_OS_X
INCLUDES += -I/usr/include/malloc
endif
			
Obj/%.o: src/%.cpp
	@echo 'Building file: $<'
	@echo 'Invoking: GCC C++ Compiler'
	$(G++) $(DEPS) $(INCLUDES) -O2 -fPIC -g -Wall -c -fmessage-length=0 -MMD -MP -MF"$(@:Obj/%.o=Obj/%.d)" -MT"$(@:Obj/%.o=Obj/%.d)" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '

# All Target
all: Common++.dynamic Common++.debug

create-directories:
	$(MKDIR) -p Obj
	$(MKDIR) -p Lib
	$(MKDIR) -p Lib/Debug
	$(MKDIR) -p Lib/Release

# Static library compilation
Common++.static: create-directories $(OBJS_FILENAMES)
	@echo 'Building staic target: $@'
	@echo 'Invoking: GCC Archiver'
	$(AR) -r "Lib/Release/$(LIB_PREFIX)Common++$(LIB_EXT)" $(OBJS_FILENAMES)
	@echo 'Finished successfully building target: $@'
	@echo ' '
	
Common++.debug: create-directories $(OBJS_FILENAMES_DEBUG)
	@echo 'Building target: $@'
	@echo 'Invoking: GCC Archiver'
	$(AR) -r "Lib/Debug/$(LIB_PREFIX)Common++$(LIB_EXT)" $(OBJS_FILENAMES_DEBUG)
	@echo 'Finished successfully building target: $@'
	@echo ' '


# Dynamic library compilation
Common++.dynamic: create-directories $(OBJS_FILENAMES)
	@echo 'Building dynamic target: $@'
	@echo 'Invoking: GCC'
	$(G++) -shared -Wl,-soname,$(LIB_PREFIX)Common++$(DYN_LIB_EXT) -o "Lib/$(LIB_PREFIX)Common++$(DYN_LIB_EXT)" $(OBJS_FILENAMES)
	@echo 'Finished successfully building dynamic target: $@'
	@echo ' '

# Clean Target
clean:
	$(RM) -rf ./Obj/*
	$(RM) -rf ./Lib/*
	@echo 'Clean finished'